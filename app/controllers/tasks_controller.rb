class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find params[:id]
  end

  def new # once past MVP, improve performance
    @assignables = User.all + Group.all
    @categories = Category.custom
    @intensity_levels = Task::INTENSITY_LEVELS
  end

  def create
  end

  def edit; end

  def update; end

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
      :categories,
      :wave
    )
  end
end
