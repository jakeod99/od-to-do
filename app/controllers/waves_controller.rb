class WavesController < ApplicationController
  before_action :wave_commitment_redirect, only: [ :index, :new, :edit ]

  def index
    @waves = Wave.all
  end

  def show
    @wave = Wave.find params[:id]
  end

  def new; end

  def create
    response = NewWaitingWaveCreator.call
    redirect_to edit_wave_path(response.content.id) if response.success?
  end

  def edit
    @tasks = @current_wave.tasks
  end

  def update
    response = WaitingWaveFinalizer.call
    redirect_to root_path if response.success?
  end

  private

  def wave_commitment_redirect
    redirect_to new_wave_path if @current_wave.nil? && action_name != "new"
    redirect_to edit_wave_path(@current_wave.id) if @current_wave&.waiting? && action_name != "edit"
    redirect_to show_wave_path(@current_wave.id) if @current_wave&.active? && action_name != "index"
  end
end
