class RecurringTaskTemplatesController < ApplicationController
  def index
    @recurring_task_templates = RecurringTaskTemplate.all
  end

  def show; end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  private

  def recurring_task_templates_params; end
end
