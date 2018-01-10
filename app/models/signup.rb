class Signup
  attr_reader :available_dates

  def initialize
    @available_dates = AvailableDate.order(day: :asc).to_a
  end

  def min
    available_dates.first&.day || Time.zone.today
  end

  def max
    if available_dates.present?
      available_dates.last.day + 1.day
    else
      Time.zone.today
    end
  end
end
