class Signup
  def initialize
  end

  def available_dates
    @available_dates ||= AvailableDate.where(name: nil).to_a
  end

  def unavailable_dates
    @unavailable_dates ||= AvailableDate.where.not(name: nil).to_a
  end

  def to_check_map_json
    {}.tap do |result|
      (available_dates + unavailable_dates).each do |date|
        result[date.day.strftime("%Y-%m-%d")] = {
          available: date.name.blank?,
          name: date.name
        }
      end
    end.to_json
  end

  def to_admin_event_sources_json
    [
      {
        events: available_dates.map do |date|
          {
            title: date.name.presence || "Available",
            start: date.day.to_s
          }
        end,
        id: "available",
        color: "#337ab7"
      },
      {
        events: unavailable_dates.map do |date|
          {
            title: date.name.presence,
            start: date.day.to_s
          }
        end,
        id: "unavailable",
        color: "#d9534f"
      }
    ].to_json
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
