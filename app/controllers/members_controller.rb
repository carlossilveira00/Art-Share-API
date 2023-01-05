class MembersController < ApplicationController

  def index
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
    current_user = User.find(jwt_payload['sub'])
    render json: current_user, status: :ok
  end

  def update_avatar
    @current_user = User.find(params[:id])
    @current_user.update!(photo: params['event']['photo'])

    render json: @current_user
  end
end
