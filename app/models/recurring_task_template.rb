class RecurringTaskTemplate < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  belongs_to :assignable, polymorphic: true, optional: true

  has_many :tasks
  has_many :recurring_task_templates_categories
  has_many :categories, through: :recurring_task_templates_categories

  validates :urgency, inclusion: { in: Task::URGENCY_LEVELS }
end
