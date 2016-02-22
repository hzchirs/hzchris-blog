class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :initial_meta_tags

  def initial_meta_tags
    set_meta_tags site: SITE_NAME, title: nil, reverse: true
  end
end
