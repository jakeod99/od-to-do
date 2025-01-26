# linking table
class CategoryTaskLink < ApplicationRecord
  self.table_name = "categories_tasks"
  belongs_to :category
  belongs_to :task
end
