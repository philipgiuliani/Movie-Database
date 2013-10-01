class HomeController < ApplicationController
	before_filter :require_login
	
  def index
    @current_user = current_user
    @movies_new = Movie.all(order: "created_at desc", limit: "0,5")
    @movies_updated = Movie.all(order: "updated_at desc", conditions: "updated_at != created_at", limit: "0,5")
  end
end
