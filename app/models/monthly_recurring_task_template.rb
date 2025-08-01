class MonthlyRecurringTaskTemplate < RecurringTaskTemplate
  DAYS_VALIDATION_REGEX = /(0?[1-9]|[12][0-9]|3[01])(,(0?[1-9]|[12][0-9]|3[01]))*/
  validates :days, format: { with: DAYS_VALIDATION_REGEX }, allow_blank: true

  def dates_in_range(start_date, end_date)
    full_date_range = (start_date..end_date).to_a
    full_date_range.keep_if { |date| days.include? date.mday }
  end

  def days
    super.map(&:to_i)
  end

  def days=(input)
    super(
      if input.is_a?(Array)
        input
          .keep_if { |e| e.to_i > 0 && e.to_i < 32 }
          .uniq
          .sort { |a, b| a.to_i <=> b.to_i }
          .join(",")
      else
        input
      end
    )
  end

  def display_days
    days.map(&:ordinalize).join(", ")
  end
end
