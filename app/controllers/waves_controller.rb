class WavesController < ApplicationController
  before_action :wave_commitment_redirect, only: [ :index, :new, :edit ]

  def index
    @old_waves = Wave.completed.order(end_at: :desc)
  end

  def show
    @wave = Wave.find params[:id]
    @generated_tasks = @wave.tasks.where("authorable_type LIKE ?", "%RecurringTaskTemplate%")
    @custom_tasks = @wave.tasks - @generated_tasks
  end

  def new; end

  def create
    response = NewWaitingWaveCreator.call
    redirect_to edit_wave_path(response.content.id) if response.success?
  end

  def edit
    @generated_tasks = @current_wave.tasks.where("authorable_type LIKE ?", "%RecurringTaskTemplate%")
    @custom_tasks = @current_wave.tasks - @generated_tasks
  end

  def update
    response = WaitingWaveFinalizer.call
    redirect_to root_path if response.success?
  end

  private

  def wave_commitment_redirect
    redirect_to new_wave_path if @current_wave.nil? && action_name != "new"
    redirect_to edit_wave_path(@current_wave.id) if @current_wave&.waiting? && action_name != "edit"
    redirect_to wave_path(@current_wave.id) if @current_wave&.active? && action_name != "index"
  end
end
