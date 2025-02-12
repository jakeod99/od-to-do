class DailyRecurringTaskTemplate < RecurringTaskTemplate
  DAYS_VALIDATION_REGEX = /\A\z/
  validates :days, format: { with: DAYS_VALIDATION_REGEX }, allow_blank: true

  def dates_in_range(start_date, end_date)
    (start_date..end_date).to_a
  end

  def display_days
    "Every Day"
  end
end
