class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authorize

  private

  def authorize
    access_token = extract_access_token_from_header
    # TODO if access_token.blank?
    @current_user_firebase_uid = access_token.first['sub']
  end

  def current_user
    return unless @current_user_firebase_uid
    @current_user ||= User.find_by(uuid: @current_user_firebase_uid)
  end

  def extract_access_token_from_header
    authenticate_with_http_token do |token, _|
      Firebase::Auth::IDTokenKeeper::IDToken.new(token).verified_id_token
    end
  rescue JWT::ExpiredSignature
    # TODO
  rescue JWT::DecodeError
    # TODO
  end
end
