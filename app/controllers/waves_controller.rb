class WavesController < ApplicationController
  def index
    @waves = Wave.all
  end

  def show; end

  def new
    @wave = Wave.current
    @tasks = @wave&.tasks
  end

  def create
    NewWaitingWaveCreator.call
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def wave_params; end
end
