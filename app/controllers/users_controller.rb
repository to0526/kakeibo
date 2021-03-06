class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_url, notice: 'ユーザーを作成しました'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_url, notice: 'ユーザーを更新しました'
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_url, notice: 'ユーザーを削除しました'
    else
      redirect_to users_url, alert: 'ユーザーを削除できませんでした'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
