class Task < ApplicationRecord
  belongs_to :assignable, polymorphic: true, optional: true
  belongs_to :authorable, polymorphic: true
  belongs_to :completed_by, class_name: "User", foreign_key: "completed_by_id", optional: true

  has_many :category_task_links, dependent: :destroy
  has_many :categories, through: :category_task_links
  has_many :task_wave_links, dependent: :destroy
  has_many :waves, through: :task_wave_links

  INTENSITY_LEVELS = {
    1 => "Very Low",
    2 => "Low",
    3 => "Medium",
    5 => "High",
    8 => "Very High"
  }.freeze
  STATUSES = [ "draft", "unstarted", "in progress", "completed", "failed", "skipped", "discarded" ].freeze

  STATUSES.each do |s|
    define_singleton_method s.to_sym do
      where(status: s)
    end
    define_method "#{s}?" do
      status == s
    end
  end

  validates :urgency, inclusion: { in: INTENSITY_LEVELS.keys }
  validates :complexity, inclusion: { in: INTENSITY_LEVELS.keys }
  validates :status, inclusion: { in: STATUSES }

  alias_method :assign=, :assignable=
  alias_method :assign_to=, :assignable=
  alias_method :assigned_to, :assignable
  alias_method :author=, :authorable=
  alias_method :author, :authorable

  before_save :update_wave_link_status, if: -> { status_changed? }

  def self.intensity_level_value(term)
    INTENSITY_LEVELS.key(term.titleize)
  end

  def self.clean_intensity_level_input(intensity)
    if !INTENSITY_LEVELS.keys.include?(intensity) && intensity.respond_to?(:to_s)
      intensity_level_value(intensity.to_s.titleize)
    else
      intensity
    end
  end

  def urgency=(intensity)
    self[:urgency] = Task.clean_intensity_level_input(intensity)
  end

  def urgency_label
    INTENSITY_LEVELS[urgency]
  end

  def urgency_value
    urgency
  end

  def complexity=(intensity)
    self[:complexity] = Task.clean_intensity_level_input(intensity)
  end

  def complexity_label
    INTENSITY_LEVELS[complexity]
  end

  def complexity_value
    complexity
  end

  def in_current_wave?
    waves.include?(Wave.current)
  end

  private

  def update_wave_link_status
    if [ "failed" ].include? status
      active_wave = waves.active.first
      task_wave_links.where(wave: active_wave).update_all(status: "foresaken")
    end
  end
end
