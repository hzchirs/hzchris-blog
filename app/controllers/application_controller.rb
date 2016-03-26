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

  def ensure_signup_complete
   # Ensure we don't go into an infinite loop
   return if action_name == 'finish_signup'

   # Redirect to the 'finish_signup' page if the user
   # email hasn't been verified yet
   if current_user && !current_user.email_verified?
     redirect_to finish_signup_path(current_user)
   end
 end
end
