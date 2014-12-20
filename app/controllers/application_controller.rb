class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
end
