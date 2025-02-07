class Wave < ApplicationRecord
  has_many :task_wave_links, dependent: :destroy
  has_many :tasks, through: :task_wave_links

  STATUSES = [ "waiting", "active", "completed" ].freeze

  def self.current
    Wave.find_by(status: "active")
  end
end
