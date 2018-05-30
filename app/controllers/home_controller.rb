class HomeController < ApplicationController
  def index
    if current_user
      redirect_to '/vacations'
    end
  end
end