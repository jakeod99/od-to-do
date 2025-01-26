class Wave < ApplicationRecord
  has_many :tasks

  STATUSES = [ "waiting", "active", "completed" ].freeze
end
