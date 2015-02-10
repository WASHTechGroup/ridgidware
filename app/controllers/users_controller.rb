class UsersController < ActionController::Base 

	def show
		@user = User.friendly.find(params[:id])
	end

end