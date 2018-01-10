class SnacksController < ApplicationController
  def index
    if ENV["SNACKS_ADMIN_KEY"].present? && params[:key] == ENV["SNACKS_ADMIN_KEY"]
      render "admin"
    elsif ENV["SNACKS_SIGNUP_KEY"].present? && params[:key] == ENV["SNACKS_SIGNUP_KEY"]
      render "signup"
    else
      render "no_access"
    end
  end
end
