class UsersController < ApplicationController

	def index
		@users = User.all_except(current_user)
	end

	def show 
		@users = User.all_except(current_user)
		render 'index'
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "Account created!"
			redirect_to root_path
		else
			flash[:error] = "Error: #{@user.errors.full_messages.to_sentence}"
			render 'new'
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
	