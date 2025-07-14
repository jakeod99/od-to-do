class TasksController < ApplicationController
  before_action :set_form_options, only: [ :new, :edit ]
  before_action(
    :set_task,
    only: [ :show, :edit, :update, :destroy, :add_to_wave, :remove_from_wave, :assign, :start ]
  )
  def index
    @tasks = Task.all
  end

  def show; end

  def new; end

  def create
    task = Task.create!(create_params)
    @current_wave.tasks << task if task_params[:wave] == "1"
    redirect_to task
  end

  def edit
    @checked_categories = @task.categories.pluck(:id)
  end

  def update
    @task.update!(update_params)
    if task_params[:wave] == "1"
      @current_wave.tasks << @task if !@current_wave.tasks.include?(@task)
    else
      @current_wave&.task_wave_links&.where(task: @task)&.delete_all
    end
    redirect_to @task
  end

  def destroy
    @task.discard!
    redirect_back(fallback_location: root_path, notice: "Task discarded successfully")
  end

  def add_to_wave
    if !@task.in_current_wave?
      @current_wave.tasks << @task
      redirect_back(fallback_location: root_path, notice: "Task added to current wave")
    end
  end

  def remove_from_wave
    tw_link = TaskWaveLink.where(wave: @current_wave, task: @task)&.first
    if tw_link
      tw_link.destroy
      redirect_back(fallback_location: root_path, notice: "Task rmeoved from current wave")
    end
  end

  def assign
    assignable = User.find_by(id: params[:assign_id]) || Group.find_by(id: params[:assign_id])
    if assignable && @task.assignable?
      @task.assign_to = assignable
      @task.save!
      redirect_back(fallback_location: root_path, notice: "Task assigned successfully")
    end
  end

  def start
    @task.start!
    redirect_back(fallback_location: root_path)
  end

  private

  def task_params
    params.permit(
      :title,
      :description,
      :complexity,
      :urgency,
      :firm_due,
      :suggested_due,
      :assign,
      :wave,
      categories: [],
      task: {},
    )
  end

  def write_params(under_task: false)
    incoming = under_task ? task_params[:task] : task_params
    assignable = User.find_by(id: incoming[:assign]) || Group.find_by(id: incoming[:assign])
    categories = Category.where(id: incoming[:categories].delete_if(&:empty?)) unless incoming[:categories].blank?
    incoming
      .slice(:title, :description, :complexity, :urgency, :firm_due, :suggested_due)
      .tap do |cp|
        cp[:complexity] = cp[:complexity].to_i
        cp[:urgency] = cp[:urgency].to_i
        cp[:assign] = assignable
        cp[:categories] = categories.to_a unless categories.nil?
      end
  end

  def create_params
    @create_params ||=
      write_params.tap do |wp|
        wp[:author] = @current_user
        wp[:status] = :unstarted
      end
  end

  def update_params
    @update_params ||= write_params(under_task: true)
  end

  def set_form_options
    @assignables = User.pluck(:name, :id) + Group.pluck(:name, :id)
    @categories = Category.custom
    @intensity_levels = Task::INTENSITY_LEVELS.to_a.map(&:reverse)
  end

  def set_task
    id = params[:id] || params[:task_id]
    @task = Task.find id
  end
end
