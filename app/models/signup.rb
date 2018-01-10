class Signup
  attr_reader :available_dates

  def initialize
    @available_dates = AvailableDate.order(day: :asc).to_a
  end

  def min
    available_dates.first&.day || Time.zone.today
  end

  def max
    available_dates.last&.day || Time.zone.today
  end
end
