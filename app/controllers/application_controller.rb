class ApplicationController < ActionController::Base
  include Pundit
  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  after_action :verify_authorized, except: [:index]

  private

  def user_not_authorized(exception)
    head :forbidden
  end
end
