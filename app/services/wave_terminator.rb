class WaveTerminator < ApplicationService
  def call
    eligible_wave_count = wave_to_terminate.count
    return failure message: "There should only be one wave eligible to end" if eligible_wave_count > 1
    return success message: "No waves need to end" if eligible_wave_count == 0
    @wave = waves.first
    ActiveRecord::Base.transaction do
      wave.complete!
    end
  end

  private

  def wave_to_terminate
    Wave.where(status: "active", end_at: ..(Date.today))
  end
end
