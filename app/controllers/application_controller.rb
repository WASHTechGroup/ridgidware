class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :sort_column, :sort_direction


  after_filter :flash_to_headers

	def flash_to_headers
		return unless request.xhr?
		response.headers['X-Message'] = flash_message
		response.headers["X-Message-Type"] = flash_type.to_s
		flash.discard # don't want the flash to appear when you reload page
	end

  private
 		def sort_column 
 			%w[part_number description price].include?(params[:sort]) ? params[:sort] : "part_number"
 		end

 		def sort_direction
 			%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc" 
 		end

 		def flash_message
			[:error, :warning, :notice].each do |type|
				return flash[type] unless flash[type].blank?
			end
		end

		def flash_type
			[:error, :warning, :notice].each do |type|
				return type unless flash[type].blank?
			end
		end

		def tier_one
			redirect_to root_url, flash: {danger: "Permision Denied"} unless current_user.tier_one?
		end

		def tier_two
			redirect_to root_url, flash: {danger: "Permision Denied"} unless current_user.tier_two?
		end

		def tier_three
			redirect_to root_url, flash: {danger: "Permision Denied"} unless current_user.tier_three?
		end

		def admin
			redirect_to root_url, flash: {danger: "Permision Denied"} unless current_user.admin?
		end
end
