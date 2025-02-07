class Wave < ApplicationRecord
  has_many :tasks

  STATUSES = [ "waiting", "active", "completed" ].freeze

  def self.current
    Wave.find_by(status: "active")
  end
end
