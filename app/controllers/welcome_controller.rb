class WelcomeController < ApplicationController
  def index
    unless current_user
      redirect_to sessions_new_path
    end
  end
end
