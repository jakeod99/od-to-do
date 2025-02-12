class WaveTerminationJob < ApplicationJob
  queue_as :default

  def perform
    WaveTerminator.call
  end
end
