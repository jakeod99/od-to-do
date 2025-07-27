class Wave < ApplicationRecord
  has_many :task_wave_links, dependent: :destroy
  has_many :tasks, through: :task_wave_links

  STATUSES = [ "waiting", "active", "completed" ].freeze

  STATUSES.each do |s|
    define_singleton_method s do
      where(status: s)
    end
    define_method "#{s}?" do
      status == s
    end
  end

  Task::STATUSES.each do |task_status|
    define_method "#{task_status}_tasks" do
      tasks.merge(TaskWaveLink.send(task_status))
    end
  end

  before_save :update_task_link_statuses, if: -> { status_changed? }

  def self.current
    find_by(status: [ "waiting", "active" ])
  end

  def self.previous
    where(status: "completed").order(:end_at).limit(1)&.first
  end

  def complete!
    self[:status] = "completed"
    self.save!
  end

  def activate!
    self[:status] = "active"
    self.save!
  end

  def fully_in_current_year?
    [ start_at.year, end_at.year ].include? DateTime.now.year
  end

  def display_range
    date_display_format = "%A, %B %-d#{", %Y" unless fully_in_current_year? }"
    start_display = start_at.strftime(date_display_format)
    end_display = end_at.strftime(date_display_format)
    "From #{start_display}, through #{end_display}."
  end

  private

  def update_task_link_statuses
    if completed?
      task_wave_links.planned.update_all(status: "rolled")
    elsif active?
      task_wave_links.update_all(status: "planned", in_initial_commitment: true)
    end
  end
end
