class HomeController < ApplicationController
  before_action :authenticate_user!
  around_action :catch_not_found

  def index
  end
end
