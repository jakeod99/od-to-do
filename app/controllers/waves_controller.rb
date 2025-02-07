class WavesController < ApplicationController
  def index
    @waves = Wave.all
  end

  def show; end

  def new
    @wave = NewWaitingWaveCreator.call.content
    @tasks = @wave.tasks
  end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  private

  def wave_params; end
end
