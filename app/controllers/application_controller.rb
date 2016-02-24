class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :initial_meta_tags

  include Pundit
  # after_action :verify_authorized, except: [:index]
  # after_action :verify_policy_scoped, only: [:index]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def initial_meta_tags
    set_meta_tags site: SITE_NAME, title: nil, reverse: true
  end

  def user_not_authorized
    flash[:alert] = "您沒有權限進行此操作"
    redirect_to(request.referrer || root_url)
  end
end
