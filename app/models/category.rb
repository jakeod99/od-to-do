class Category < ApplicationRecord
  has_many :category_task_links, dependent: :destroy
  has_many :tasks, through: :category_task_links
  has_many :category_recurring_task_template_links, dependent: :destroy
  has_many :recurring_task_templates, through: :category_recurring_task_template_links
end
