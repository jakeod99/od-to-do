class TaskTerminationJob < ApplicationJob
  queue_as :default

  def perform
    TaskTerminator.call
  end
end
