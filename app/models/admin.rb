class Admin
  attr_reader :params, :flash

  def initialize(params)
    @params = params
  end

  def execute
    case params[:admin_action]
    when "create"
      create!
    else
      raise "Invalid action: #{params[:admin_action]}"
    end
  end

  def create!
    existing = AvailableDate.where(day: params[:day]).first
    raise "That already exists!" if existing.present?
    date = AvailableDate.create! day: params[:day], name: params[:existing_name].presence
    @flash = { success: "Successfully added #{date.day}" }
  end
end
