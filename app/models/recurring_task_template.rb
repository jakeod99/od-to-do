class RecurringTaskTemplate < ApplicationRecord
  belongs_to :assignable, polymorphic: true, optional: true
  belongs_to :author, class_name: "User", foreign_key: "author_id"

  has_many :authored_tasks, class_name: "Task", foreign_key: "authorable_id", as: :authorable
  has_many :category_recurring_task_template_links, dependent: :destroy
  has_many :categories, through: :category_recurring_task_template_links

  STATUSES = [ "inactive", "active", "discarded" ].freeze

  validates :urgency, inclusion: { in: Task::INTENSITY_LEVELS.keys }
  validates :complexity, inclusion: { in: Task::INTENSITY_LEVELS.keys }
  validates :status, inclusion: { in: STATUSES }

  alias_method :assign=, :assignable=
  alias_method :assign_to=, :assignable=
  alias_method :assigned_to, :assignable

  before_create :set_categories

  def dates_in_range(start_date, end_date)
    raise NotImplementedError
  end

  def days
    super&.split(",") || []
  end

  def urgency=(intensity)
    super(Task.clean_intensity_level_input(intensity))
  end

  def urgency_label
    Task::INTENSITY_LEVELS[urgency]
  end

  def urgency_value
    urgency
  end

  def complexity=(intensity)
    super(Task.clean_intensity_level_input(intensity))
  end

  def complexity_label
    Task::INTENSITY_LEVELS[complexity]
  end

  def complexity_value
    complexity
  end

  def categories=(input)
    new_input = (Array.wrap(input) << Category.find_by(name: "Recurring")).uniq
    super(new_input)
  end

  def short_type
    type.split(/(?=[A-Z])/).first
  end

  def create_tasks(start_date, end_date)
    create_arr = dates_in_range(start_date, end_date).map do |date|
      task_create_hash(date)
    end
    Task.create!(create_arr)
  end

  private

  def task_create_hash(date)
    {
      status: :unstarted,
      title: title,
      description: description,
      complexity: complexity,
      urgency: urgency,
      author: self
    }.tap do |hash|
      due_key = is_firm ? :firm_due : :suggested_due
      hash[due_key] = date
      hash[:assign] = assigned_to if assigned_to
    end
  end

  def set_categories
    self.categories = [] if self.categories.empty?
  end
end
