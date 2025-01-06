class Group < ApplicationRecord
  has_many :users_groups
  has_many :users, through: :users_groups
  has_many :recurring_task_templates, as: :assignable
  has_many :tasks, as: :assignable
end
