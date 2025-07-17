class YearlyRecurringTaskTemplate < RecurringTaskTemplate
  DAYS_VALIDATION_REGEX = /(0?[1-9]|1[012])\/(0?[1-9]|[12][0-9]|3[01])(,(0?[1-9]|1[012])\/(0?[1-9]|[12][0-9]|3[01]))*/
  validates :days, format: { with: DAYS_VALIDATION_REGEX }, allow_blank: true

  def dates_in_range(start_date, end_date)
    years_in_range = (start_date.year..end_date.year).to_a
    ydays = {}
    years_in_range.each do |year|
      dates = days.map do |date_str|
        date_arr = date_str.split("/")
        Date.try(:parse, "#{date_arr.second}/#{date_arr.first}/#{year}")
      end
      ydays[year] = dates.map(&:yday)
    end
    full_date_range = (start_date..end_date).to_a
    full_date_range.keep_if { |date| ydays[date.year].include? date.yday }
  end

  def days=(input)
    new_input =
      if input.is_a? Array
        input
          .map { |date| date.is_a?(Date) ? "#{date.month}/#{date.mday}" : date.to_s }
          .keep_if do |d|
            month, day = d.split("/")
            month.to_i > 0 && month.to_i < 13 && day.to_i > 0 && day.to_i < 32
          end
          .uniq
          .sort do |a, b|
            a_arr = a.split("/").map(&:to_i)
            b_arr = b.split("/").map(&:to_i)
            a_arr <=> b_arr # compares first element (months), then second (day) if necessary
          end
          .join(",")
      else
        input
      end
    super(new_input)
  end
end
