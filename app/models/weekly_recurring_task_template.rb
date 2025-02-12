class WeeklyRecurringTaskTemplate < RecurringTaskTemplate
  DAYS_VALIDATION_REGEX = /(sun|mon|tues|wednes|thurs|fri|satur)day(,(sun|mon|tues|wednes|thurs|fri|satur)day)*/
  validates :days, format: { with: DAYS_VALIDATION_REGEX }, allow_blank: true

  def dates_in_range(start_date, end_date)
    wdays = days.map { |weekday| weekday_as_wday(weekday) }
    full_date_range = (start_date..end_date).to_a
    full_date_range.keep_if { |date| wdays.include? date.wday }
  end

  def days=(input)
    new_input =
      if input.is_a? Array
        days_arr = input.map do |raw_weekday|
          weekday = raw_weekday.try(:downcase) || raw_weekday
          WEEKDAY_MAP.keys.include?(weekday.to_s) ? weekday.to_s : WEEKDAY_MAP.key(weekday)
        end
        days_arr.join(",")
      else
        input
      end
    super(new_input)
  end

  def display_days
    days.map(&:titleize).join(", ")
  end

  private

  WEEKDAY_MAP = {
    "sunday" =>     0,
    "monday" =>     1,
    "tuesday" =>    2,
    "wednesday" =>  3,
    "thursday" =>   4,
    "friday" =>     5,
    "saturday" =>   6
  }.freeze

  def weekday_as_wday(weekday)
    return weekday unless WEEKDAY_MAP.keys.include?(weekday.try(:downcase))
    WEEKDAY_MAP[weekday.downcase]
  end
end
