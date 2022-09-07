class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    @users = User.order('created_at ASC')


    render :json => @users, each_serializer: UsersSerializer

  end

end
