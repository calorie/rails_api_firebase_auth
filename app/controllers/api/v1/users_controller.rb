class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(uuid: @current_user_firebase_uid)
    user.save!
    render json: UserSerializer.new(user).serialized_json
  end
end
