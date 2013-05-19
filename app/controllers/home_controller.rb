class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to :controller => :village, :action => :show,
                  :id => current_user.villages.first.id
    end
  end
end
