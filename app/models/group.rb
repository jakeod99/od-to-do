class Group < ApplicationRecord
  has_many :assigned_recurring_task_templates, class_name: "RecurringTaskTemplate", foreign_key: "assignable_id", as: :assignable
  has_many :assigned_tasks, class_name: "Task", foreign_key: "assignable_id", as: :assignable
  has_many :group_user_links, dependent: :destroy
  has_many :users, through: :group_user_links
end
