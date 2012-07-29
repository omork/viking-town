class HomeController < ApplicationController
  def index
    if user_signed_in?
      begin
        redirect_to :controller => :village, :action => :show, :id => current_user.villages.first.id
        return
      rescue RuntimeError
      end
    end
  end
end
