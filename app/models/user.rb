class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :users_groups
  has_many :groups, through: :users_groups
  has_many :recurring_task_templates, as: :assignable
  has_many :authored_recurring_task_templates, class_name: "RecurringTaskTemplate", foreign_key: "author_id"
  has_many :assigned_tasks, class_name: "Task", foreign_key: "assignable_id", as: :assignable
  has_many :authored_tasks, class_name: "Task", foreign_key: "author_id"
  has_many :completed_tasks, class_name: "Task", foreign_key: "completed_by_id"

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def admin?
    type == "Admin"
  end
end
