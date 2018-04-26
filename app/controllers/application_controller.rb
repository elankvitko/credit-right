class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

    def catch_not_found
      yield
    rescue ActiveRecord::RecordNotFound
      redirect_to root_url
    end
end
