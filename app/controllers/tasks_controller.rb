class TasksController < ApplicationController
  before_action :set_form_options, only: [ :new, :edit ]
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find params[:id]
  end

  def new; end

  def create
    task = Task.create!(create_params)
    @current_wave.tasks << task if task_params[:wave] == "1"
    redirect_to task
  end

  def edit
    @task = Task.find params[:id]
    @checked_categories = @task.categories.pluck(:id)
  end

  def update
    task = Task.find params[:id]
    task.update!(update_params)
    if task_params[:wave] == "1"
      @current_wave.tasks << task if !@current_wave.tasks.include?(task)
    else
      @current_wave&.task_wave_links&.where(task: task)&.delete_all
    end
    redirect_to task
  end

  def destroy; end

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
    puts incoming.inspect
    assignable = User.find_by(id: incoming[:assign]) || Group.find_by(id: incoming[:assign])
    categories = Category.where(id: incoming[:categories].delete_if(&:empty?)) unless incoming[:categories].blank?
    incoming
      .slice(:title, :description, :complexity, :urgency, :firm_due, :suggested_due)
      .tap do |cp|
        cp[:complexity] = cp[:complexity].to_i
        cp[:urgency] = cp[:urgency].to_i
        cp[:assign] = assignable unless assignable.nil?
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
end
