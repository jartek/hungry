class ApplicationController < ActionController::Base
  include Pundit
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    head :forbidden
  end
end
