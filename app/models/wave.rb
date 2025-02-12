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

  before_save :update_wave_link_status, if: -> { status_changed? }

  def self.current
    find_by(status: "active")
  end

  def self.previous
    where(status: "completed").order(:end_at).limit(1)
  end

  private

  def update_wave_link_status
    task_wave_links.planned.update_all(status: "rolled") if status == "completed"
  end
end
