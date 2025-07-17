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
  STATUSES = [ "draft", "unstarted", "in_progress", "completed", "failed", "skipped", "discarded" ].freeze

  default_scope -> { where.not(status: "discarded") }

  scope :unfinished, -> { where(status: [ "draft", "unstarted", "in_progress" ]) }
  scope :finished, -> { where(status: [ "completed", "failed", "skipped", "discarded" ]) }

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

  def discardable?
    waves.where.not(status: "waiting").empty? && assignable?
  end

  def discard!
    return unless discardable?

    self[:status] = "discarded"
    save!
  end

  def assignable?
    draft? || unstarted?
  end

  def unassign!
    self.assignable = nil
    self.save!
  end

  def startable?
    unstarted? && in_current_wave?
  end

  def start!
    return unless startable?

    self[:status] = "in_progress"
    save!
  end

  def unstartable?
    in_progress?
  end

  def unstart!
    return unless unstartable?

    self[:status] = "unstarted"
    save!
  end

  def completable?
    startable? || in_progress?
  end

  def complete!(by_user:)
    return unless completable?

    self[:status] = "completed"
    self.completed_by = by_user if by_user
    self.completed_at = DateTime.now
    save!
  end

  def finished?
    completed? || failed? || skipped? || discarded?
  end

  def unfinished?
    !finished?
  end

  def editable?
    unfinished?
  end

  def skippable?
    unfinished?
  end

  def skip!
    return unless skippable?

    self[:status] = "skipped"
    save!
  end

  def assigned_to?(id)
    assignable_id == id
  end

  private

  def update_wave_link_status
    active_wave = waves.active.first
    if active_wave.present?
      if failed? || discarded? || skipped?
        task_wave_links.where(wave: active_wave).update_all(status: "foresaken")
      elsif completed?
        task_wave_links.where(wave: active_wave).update_all(status: "completed")
      end
    end
  end
end
