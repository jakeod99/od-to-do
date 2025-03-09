class WaveTerminator < ApplicationService
  def call
    waves = waves_to_terminate
    return failure message: "There should only be one wave eligible to end" if waves.count > 1
    return success message: "No waves need to end" if waves.count == 0
    wave = waves.first
    begin
      ActiveRecord::Base.transaction do
        wave.complete!
      end
    rescue ActiveRecord::Rollback => e
      return failure message: "Transaction block rollback '#{e.message}'"
    end
    success content: wave
  end

  private

  def waves_to_terminate
    Wave.where(status: "active", end_at: ..(Date.yesterday))
  end
end
