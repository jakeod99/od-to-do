class WaitingWaveFinalizer < ApplicationService
  def initialize(wave: Wave.current)
    @wave = wave
  end

  def call
    return failure message: "Wave must be current waiting wave to be finalized" unless valid?

    begin
      ActiveRecord::Base.transaction do
        @wave.activate!
      end
    rescue ActiveRecord::Rollback => e
      return failure message: "transaction block rollback '#{e.message}'"
    end
    success content: @wave
  end

  private

  def valid?
    @wave.waiting? && @wave == Wave.current
  end
end
