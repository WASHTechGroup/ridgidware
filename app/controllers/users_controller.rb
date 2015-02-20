class UsersController < ApplicationController

	before_action :correct_user, only: [:edit, :update, :show]
	# before_action :admin_user,   only: [:index] 

	def index 
		@users = User.all
	end

	def show
		@user = User.friendly.find(params[:id])
	end

	def edit
		@user = current_user
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def update_role(role)
		if current_user.update_attribute(:role, Role.find_by_name(role))	
			flash[:success] = "Role Updated"
		else
			flash[:error] = "Role not Updated"
		end
	end

	private 

		def user_params
			params.require(:user).permit(:firstname, :lastname, :email, :phonenumber, :program, :term, :year)
		end

		def correct_user
			@user = User.friendly.find(params[:id])
			redirect_to(root_url) unless current_user == @user
		end

		def admin_user 
			redirect_to(root_url) unless current_user.role == Role.find_by_name("Admin")
		end
end