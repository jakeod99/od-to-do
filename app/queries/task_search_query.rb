class TaskSearchQuery < ApplicationQuery
  module Scopes
    def by_title(title)
      return self if title.blank?

      where("title ILIKE ?", "%#{title}%")
    end

    def by_wave(wave)
      options = [ "Current Wave", "Outside Current Wave" ]
      return self unless options.include? wave

      if wave == "Current Wave"
        joins(:waves).where(waves: Wave.current)
      elsif wave == "Outside Current Wave"
        where.not(id: Wave.current.tasks.pluck(:task_id))
      end
    end

    def by_source(source)
      options = [ "Custom", "Generated" ]
      return self unless options.include? source

      if source == "Custom"
        where("authorable_type LIKE ?", "%User%")
      elsif source == "Generated"
        where("authorable_type LIKE ?", "%RecurringTaskTemplate%")
      end
    end

    def due_after(date)
      return self if date.blank?

      where("firm_due >= ? OR suggested_due >= ?", date, date)
    end

    def due_before(date)
      return self if date.blank?

      where("firm_due <= ? OR suggested_due <= ?", date, date)
    end

    def by_urgency(urgency)
      return self if urgency.blank? || urgency.to_a.keep_if(&:present?).blank?

      where(urgency: urgency.to_a)
    end

    def by_complexity(complexity)
      return self if complexity.blank? || complexity.to_a.keep_if(&:present?).blank?

      where(complexity: complexity.to_a)
    end

    def by_status(status)
      return self if status.blank? || status.to_a.keep_if(&:present?).blank?

      where(status: status.to_a)
    end

    def by_category(category_ids)
      return self if category_ids.blank? || category_ids.to_a.keep_if(&:present?).blank?

      joins(:categories).where(categories: { id: category_ids })
    end

    def by_assigned_to(assigned_to_ids)
      return self if assigned_to_ids.blank? || assigned_to_ids.to_a.keep_if(&:present?).blank?

      where(assignable_id: assigned_to_ids)
    end
  end

  def initialize(scope: Task.all)
    @scope = scope
  end

  def query(filters: {})
    @scope
      .extending(Scopes)
      .by_title(filters[:title])
      .by_wave(filters[:wave])
      .by_source(filters[:source])
      .due_after(filters[:due_after])
      .due_before(filters[:due_before])
      .by_urgency(filters[:urgency])
      .by_complexity(filters[:complexity])
      .by_status(filters[:status])
      .by_category(filters[:categories])
      .by_assigned_to(filters[:assigned_to])
      .order(updated_at: :desc)
      .distinct
  end
end
