class Signup
  attr_reader :params, :flash

  def initialize(params = {})
    @params = params
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

  def to_event_sources_json
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
    @min ||= AvailableDate.order(day: :asc).first&.day || Time.zone.today
  end

  def max
    @max ||=
      begin
        date = AvailableDate.order(day: :desc).first

        if date.present?
          date.day + 1.day
        else
          time.zone.today
        end
      end
  end

  def execute
    case params[:signup_action]
    when "signup"
      signup!
    else
      raise "Invalid action: #{params[:signup_action]}"
    end
  end

  def signup!
    raise "You must provide a name!" unless params[:name].present?
    date = AvailableDate.where(day: params[:day]).first
    raise "That is not an existing date!" unless date.present?
    raise "That date is already chosen!" if date.name.present?
    date.name = params[:name].presence
    date.save!
    @flash = { success: "You successfully signed up for #{date.day.strftime("%A, %B #{date.day.day.ordinalize}, %Y")}" }
  end
end
