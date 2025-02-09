class Wave < ApplicationRecord
  has_many :task_wave_links, dependent: :destroy
  has_many :tasks, through: :task_wave_links

  STATUSES = [ "waiting", "active", "completed" ].freeze

  STATUSES.each do |s|
    define_method "#{s}?" do
      status == s
    end
  end

  def self.current
    find_by(status: "active")
  end

  def self.previous
    where(status: "completed").order(:end_at).limit(1)
  end
end
