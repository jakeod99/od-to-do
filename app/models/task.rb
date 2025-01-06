class Task < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  belongs_to :assignable, polymorphic: true, optional: true
  belongs_to :completed_by, class_name: "User", foreign_key: "completed_by_id", optional: true
  belongs_to :recurring_task_template, optional: true
  belongs_to :wave, optional: true

  has_many :tasks_categories
  has_many :categories, through: :tasks_categories

  URGENCY_LEVELS = [ "none", "low", "medium", "high", "urgent" ].freeze
  STATUSES = [ "", "", "", "", "" ].freeze

  validates :urgency, inclusion: { in: URGENCY_LEVELS }
end
