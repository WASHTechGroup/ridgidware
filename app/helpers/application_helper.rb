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

	def link_to_remove_fields(name, f)
    	link_to(name, "#", class: "remove_fields", onclick: "remove_fields(this)")
	end
  
	def link_to_add_fields(name, f, association)
		new_object = f.object.send(association).build
		puts new_object
		id = new_object.object_id
		puts id
		fields = f.fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.singularize + "_field", :f => builder)
		end
		link_to(name, '#', class: "add_fields", onclick: "add_fields(this)", data: {id: id, fields: fields.gsub("\n", "")})
	end

end
