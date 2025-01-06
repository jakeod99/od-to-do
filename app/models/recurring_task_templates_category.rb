# linking table
class RecurringTaskTemplatesCategory < ApplicationRecord
  belongs_to :recurring_task_template
  belongs_to :category
end
