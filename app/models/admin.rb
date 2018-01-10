class Admin
  attr_reader :params, :flash

  def initialize(params)
    @params = params
  end

  def execute
    case params[:admin_action]
    when "add"
      create!
    when "edit"
      update!
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

  def update!
    date = AvailableDate.where(day: params[:day]).first
    raise "That is not an existing date!" unless date.present?

    if params[:delete].present?
      date.destroy!
      name_message = " signed up by: #{date.name}" if date.name.present?
      @flash = { danger: "Successfully deleted #{date.day}#{name_message}" }
    else
      date.name = params[:existing_name].presence
      date.save!
      @flash = { success: "Successfully edited #{date.day}" }
    end
  end
end
