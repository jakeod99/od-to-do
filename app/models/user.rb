class User < ApplicationRecord
  has_secure_password
  has_many :assigned_recurring_task_templates, class_name: "RecurringTaskTemplate", as: :assignable
  has_many :assigned_tasks, class_name: "Task", as: :assignable
  has_many :authored_recurring_task_templates, class_name: "RecurringTaskTemplate", foreign_key: "author_id"
  has_many :authored_tasks, class_name: "Task", as: :authorable
  has_many :completed_tasks, class_name: "Task", foreign_key: "completed_by_id"
  has_many :group_user_links, dependent: :destroy
  has_many :groups, through: :group_user_links
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def admin?
    type == "Admin"
  end
end
