class NewWaitingWaveCreator < ApplicationService
  MINIMUM_WAVE_LENGTH = 2.freeze

  def initialize(start_date: Date.today, end_date: nil)
    @start_date = start_date
    @end_date = end_date || following_saturday
    @waiting_wave = nil
  end

  def call
    return failure message: "invalid params #{@start_date} - #{@end_date}" unless valid?

    begin
      ActiveRecord::Base.transaction do
        create_waiting_wave
        add_existing_tasks
        generate_recurring_tasks
      end
    rescue ActiveRecord::Rollback => e
      return failure message: "transaction block rollback '#{e.message}'"
    end
    success content: @waiting_wave
  end

  private

  def following_saturday
    @start_date + days_until_following_saturday
  end

  def days_until_following_saturday
    (((13 - MINIMUM_WAVE_LENGTH) - @start_date.wday) % 7) + MINIMUM_WAVE_LENGTH
  end

  def valid?
    wave_length_meets_minimum? && !other_eligible_waves?
  end

  def wave_length_meets_minimum?
    ((@end_date - @start_date).to_i + 1) >= MINIMUM_WAVE_LENGTH
  end

  def other_eligible_waves?
    Wave.current
  end

  def create_waiting_wave
    @waiting_wave = Wave.create!(
      status: "waiting",
      start_at: @start_date.in_time_zone,
      end_at: @end_date.in_time_zone.change(hour: 23, min: 59, sec: 59)
    )
  end

  def add_tasks(tasks)
    @waiting_wave.tasks << tasks
  end

  def rolling_tasks
    Wave.previous&.tasks&.unfinished || []
  end

  def tasks_due_in_range
    Task
      .unfinished
      .where(firm_due: (@start_date..@end_date))
      .or(
        Task
          .unfinished
          .where(suggested_due: (@start_date..@end_date))
      )
      .distinct
  end

  def relevant_existing_tasks
    (rolling_tasks + tasks_due_in_range).uniq
  end

  def add_existing_tasks
    add_tasks relevant_existing_tasks
  end

  def generate_recurring_tasks # much room for performance optimization!
    RecurringTaskTemplate.active.each do |template|
      add_tasks template.create_tasks!(@start_date, @end_date)
    end
  end
end
