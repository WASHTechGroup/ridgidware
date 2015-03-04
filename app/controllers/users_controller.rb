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
		respond_to do |format|
			role = Role.find(params[:user][:role_id])
			user = User.friendly.find(params[:user][:username])
			if user !=  current_user
				if user.update_attribute(:role, role)	
					format.html { redirect_to :back, notice: "#{user.username} role has been updated" }
					current_user.save
				else
					format.html { redirect_to :back, user_notice: "An error occured" }
				end
			else
				format.html { redirect_to :back, user_notice: "You can't change your own role" }
			end
		end
	end

	def remove_user
		respond_to do |format|
			if user = User.friendly.find(params[:user][:username])
				if user != current_user
					if user.destroy
						format.html { redirect_to :back, notice: "#{params[:user][:username]} has been removed" }
					else
						format.html { redirect_to :back, user_notice: "An error occured" }
					end
				else
					format.html { redirect_to :back, user_notice: "You can't delete yourself" }
				end
			else 
				format.html { redirect_to :back, notice: "#{params[:user][:username]} could not be found"}
			end
		end
	end

	def add_user
		respond_to do |format|
			if @user = User.new(user_params)
				if @user.save 
					format.html { redirect_to :back, notice: "#{@user.username} has been added as a #{@user.role}" }
					format.json { render json: @user }
				else
					format.html { redirect_to :back, user_notice: "#{@user.errors.count}" }
				end
			else
			 format.html { redirect_to :back, notice: "An error occured"}
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