class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find params[:id]
  end

  def new
    
  end

  def create
    Task.create! task_params
  end

  def edit; end

  def update
    Task.update_attributes! task_params
  end

  def destroy
    Task.destroy params[:id]
  end

  private

  def task_params
    params.require(:task).permit(
      :title,
      :description,
      :firm_due,
      :suggested_due,
      :complexity,
      :urgency,
      :authorable_id,
      :authorable_type,
      :assignable_id,
      :assignable_type,
      :completed_by_id,
      :completed_at
    )
  end
end
