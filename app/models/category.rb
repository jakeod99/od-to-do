class Category < ApplicationRecord
  has_many :tasks_categories
  has_many :tasks, through: :tasks_categories
  has_many :recurring_task_templates_categories
  has_many :recurring_task_templates, through: :recurring_task_templates_categories
end
