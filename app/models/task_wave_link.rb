# linking table with attributes
class TaskWaveLink < ApplicationRecord
  self.table_name = "tasks_waves"
  belongs_to :task
  belongs_to :wave

  STATUSES = [ "planned", "rolled", "completed", "foresaken" ].freeze

  STATUSES.each do |s|
    define_singleton_method s do
      where(status: s)
    end
    define_method "#{s}?" do
      status == s
    end
  end
end
