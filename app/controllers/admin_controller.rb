class AdminController < ApplicationController
	before_filter :permision, only: :index

	def index
	end

	private
		def permision
			redirect_to(root_url) unless current_user.admin? || current_user.manager?
		end

		def admin
			redirect_to(root_url) unless current_user.admin?
		end

		def manager 
			redirect_to(root_url) unless current_user.manager?
		end
end
