class UsersController < ApplicationController
  before_action :authenticate, only: [ :index, :show, :update, :destroy ]
  before_action :authenticate_admin, only: [ :index ]

  def index
    users = User.all
    render json: { users: }
  end

  def show
    user = User.find(params[:id])
    render_unauthorized unless current_user?(user)

    render json: { user: }
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: { user: }, status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    render_unauthorized unless current_user?(user)
    if user.update(user_params)
      render json: { user: }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    render_unauthorized unless current_user?(user)

    user.destroy
    render json: { user: }
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
