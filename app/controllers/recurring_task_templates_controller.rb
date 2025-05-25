class RecurringTaskTemplatesController < ApplicationController
  before_action :set_form_options, only: [ :new, :edit ]
  def index
    @recurring_task_templates = RecurringTaskTemplate.all
  end

  def show
    @recurring_task_template = RecurringTaskTemplate.find params[:id]
  end

  def new; end

  def create
    RecurringTaskTemplate.create!(create_params)
    redirect_to root_path
  end

  def edit
    @recurring_task_template = RecurringTaskTemplate.find params[:id]
  end

  def update; end

  def destroy; end

  private

  def recurring_task_template_params
    params.permit(
      :title,
      :description,
      :complexity,
      :urgency,
      :frequency,
      :days,
      :assign,
      :active,
      :is_firm,
      categories: []
    )
  end

  def create_params
    incoming = recurring_task_template_params
    type = "#{incoming[:frequency]}RecurringTaskTemplate"
    days = incoming[:days].gsub(/\s+/, "").split(",")
    assignable = User.find_by(id: incoming[:assign]) || Group.find_by(id: incoming[:assign])
    categories = Category.where(id: incoming[:categories].delete_if(&:empty?))
    is_firm = incoming[:is_firm] == "1"
    status = incoming[:active] == "1" ? "active" : "inactive"
    incoming
      .slice(:title, :description, :complexity, :urgency)
      .tap do |cp|
        cp[:type] = type
        cp[:days] = days unless incoming[:frequency] == "Daily"
        cp[:complexity] = cp[:complexity].to_i
        cp[:urgency] = cp[:urgency].to_i
        cp[:assign_to] = assignable unless assignable.nil?
        cp[:categories] = categories.to_a
        cp[:author] = @current_user
        cp[:is_firm] = is_firm
        cp[:status] = status
      end
  end

  def set_form_options
    @assignables = User.pluck(:name, :id) + Group.pluck(:name, :id)
    @categories = Category.custom
    @intensity_levels = Task::INTENSITY_LEVELS.to_a.map(&:reverse)
  end
end
