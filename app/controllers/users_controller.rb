class UsersController < ApplicationController
	before_action :restrict_to_signed_in, only: [:new, :create, :index]

	def index
		@users = User.all
	end

	def edit
		@user = User.find(params[:id])
	end

  def show
    @user = User.find(params[:id])
    @user_events = @user.events
  end

	def new
		@user = User.new
	end

	def update
		@user = User.find(params[:id])

		if @user.update(user_params)
			redirect_to users_path
		else
			render 'edit'
		end
	end

	def create
		@user = User.create(user_params)

		if @user.save && @user.authenticate(params[:user][:password])
			redirect_to new_user_path
		else
			render :new
		end
	end

	def following
		@title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
	end

	def followers
		@title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
	end

	private

	def user_params
		params.require(:user).permit(:username,:email,:password, :password_confirmation)
	end

end
