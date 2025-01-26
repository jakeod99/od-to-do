# linking table with attributes
class TaskWaveLink < ApplicationRecord
  self.table_name = "tasks_waves"
  belongs_to :task
  belongs_to :wave

  STATUS = [ "planned", "rolled", "completed", "failed", "skipped", "discarded" ].freeze
end
