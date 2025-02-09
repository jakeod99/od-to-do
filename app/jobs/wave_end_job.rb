class WaveEndJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "Sidekiq ran as expected!"
  end
end
