class UsersController < ApplicationController

	before_action :correct_user, only: [:edit, :update, :show]
	before_action :admin_user,   only: [:index, :update_role, :remove_user] 

	def index 
		@users = User.all
		@user = User.new
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

	def update_role
		role = Role.find_by(params[:user][:role])
		user = User.friendly.find(params[:user][:username])
		if user.update_attribute(:role, role)	
			flash[:success] = "Role Updated"
			current_user.save
		else
			flash[:error] = "Role not Updated"
		end
	end

	def remove_user
		user = User.friendly.find(params[:user][:username])
		if user 
			user.destroy
		end
	end

	def add_user
		@user = User.new(user_params)
		respond_to do |format|
			if @user.save 
				format.html { redirect_to :back, notice: "#{@user.username} has been added as a #{@user.role}" }
				format.json { render json: @user }
			else
				format.html { redirect_to :back, user_notice: "#{@user.errors.count}" }
			end
		end
	end

	private 

		def user_params
			params.require(:user).permit(:username, :role_id, :firstname, :lastname, :email, :phonenumber, :program, :term, :year)
		end

		def correct_user
			@user = User.friendly.find(params[:id])
			redirect_to(root_url) unless current_user == @user
		end

		def admin_user 
			redirect_to(root_url) unless current_user.role == Role.find_by_name("Admin")
		end
end