class SnacksController < ApplicationController
  def index
    @signup = Signup.new

    if ENV["SNACKS_ADMIN_KEY"].present? && params[:key] == ENV["SNACKS_ADMIN_KEY"]
      render "admin"
    elsif ENV["SNACKS_SIGNUP_KEY"].present? && params[:key] == ENV["SNACKS_SIGNUP_KEY"]
      render "signup"
    else
      render "no_access"
    end
  end

  def update
    if ENV["SNACKS_ADMIN_KEY"].present? && params[:key] == ENV["SNACKS_ADMIN_KEY"]
      admin = Admin.new(params)
      admin.execute
      redirect_to snacks_path(params[:key]), flash: admin.flash
    elsif ENV["SNACKS_SIGNUP_KEY"].present? && params[:key] == ENV["SNACKS_SIGNUP_KEY"]
      redirect_to snacks_path(params[:key])
    else
      redirect_to snacks_path(params[:key]), flash: { danger: "You do not have access to do that!" }
    end
  end
end
