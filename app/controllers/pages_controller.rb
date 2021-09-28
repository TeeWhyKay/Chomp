class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if params["chomped"]
      # check if chomp session is found
      # if yes, redirect to the session page
      if ChompSession.find_puid(params["chomped"])
        redirect_to ChompSession.find_puid(params["chomped"])
        # redirect_to new_chomp_session_response_path(ChompSession.find_puid(params["chomped"]))
      else
        # if no, redirect back to landing page with error message
        redirect_to root_path, notice: "Session not found"
      end
    end
  end

  def favorites
    @favorites = current_user.all_favorites
  end
end
