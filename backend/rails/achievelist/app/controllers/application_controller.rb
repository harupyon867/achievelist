class ApplicationController < ActionController::API
  include ActionController::Cookies

  def authenticate
    auth = TokenHandler.decode_token(request.headers[:Authorization])
    return ResponseGenerator.un_authorized_error if auth == false

    auth[0]['sub'].to_s
  end
end
