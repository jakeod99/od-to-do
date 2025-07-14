class RecurringTaskTemplatesController < ApplicationController
  before_action :set_form_options, only: [ :new, :edit ]
  before_action :set_recurring_task_template, only: [ :show, :edit, :destroy ]
  def index
    @recurring_task_templates = RecurringTaskTemplate.all
  end

  def show; end

  def new; end

  def create
    rtt = RecurringTaskTemplate.create!(create_params)
    redirect_to recurring_task_template_path(rtt.id)
  end

  def edit
    @checked_categories = @recurring_task_template.categories.pluck(:id)
  end

  def update
    rtt = RecurringTaskTemplate.find params[:id]
    rtt.update!(type: update_params[:type]) unless update_params[:type] == rtt.type

    rtt = RecurringTaskTemplate.find params[:id] # initializes with new type
    rtt.update!(update_params)
    redirect_to recurring_task_template_path(rtt.id)
  end

  def destroy
    @recurring_task_template.discard!
    redirect_back(fallback_location: root_path, notice: "Recurring Task Template discarded successfully")
  end

  private

  def rtt_params
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
      categories: [],
      daily_recurring_task_template: {},
      weekly_recurring_task_template: {},
      monthly_recurring_task_template: {},
      yearly_recurring_task_template: {},
    )
  end

  def write_params(under_rtt: false)
    incoming =
      if under_rtt
        rtt_params.keep_if { |key, value| key.include?("recurring_task_template") }.values.first
      else
        rtt_params
      end
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
        cp[:assign_to] = assignable
        cp[:categories] = categories.to_a
        cp[:author] = @current_user
        cp[:is_firm] = is_firm
        cp[:status] = status
      end
  end

  def create_params
    @create_params ||=
      write_params.tap do |wp|
        wp[:author] = @current_user
      end
  end

  def update_params
    @update_params ||= write_params(under_rtt: true)
  end

  def set_form_options
    @assignables = User.pluck(:name, :id) + Group.pluck(:name, :id)
    @categories = Category.custom
    @intensity_levels = Task::INTENSITY_LEVELS.to_a.map(&:reverse)
  end

  def set_recurring_task_template
    @recurring_task_template = RecurringTaskTemplate.find params[:id]
  end
end
