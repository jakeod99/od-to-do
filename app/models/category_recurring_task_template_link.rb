# linking table
class CategoryRecurringTaskTemplateLink < ApplicationRecord
  self.table_name = "categories_recurring_task_templates"
  belongs_to :category
  belongs_to :recurring_task_template
end
