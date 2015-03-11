module ApplicationHelper
	def flash_class(level)
		case level
			when :notice then "alert alert-info"
			when :success then "alert alert-success"
			when :error then "alert alert-error"
			when :alert then "alert alert-error"
		end
	end

	def sortable(name, title=nil)
		title ||= name.titleize
		css_class = name == sort_column ? "current #{sort_direction}" : nil
		direction = name == sort_column && sort_direction == "asc" ? "desc" : "asc"
		link_to title, params.merge(sort: name, direction: direction), {:class => css_class}
	end
end
