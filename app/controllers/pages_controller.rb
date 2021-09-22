class PagesController < ApplicationController
  def home
    if params["chomped"]
      # check if chomp session is found
      # if yes, redirect to the session page
      if ChompSession.find_by(id: params["chomped"].to_i)
        redirect_to ChompSession.find_by(id: params["chomped"].to_i)
      else
        # if no, redirect back to landing page with error message
        redirect_to root_path, notice: "Session not found"
      end
    end
  end
end
