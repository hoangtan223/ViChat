module UsersHelper
	def flash_class_name(key)
		case key.to_s
		when 'success'
			"alert-success"
		when 'error'
			"alert-danger"
		else
			"alert-warning"
		end
	end

	def relationship_button(user)
		case current_user.get_relationship user
		when "friend"
			content_tag(:div, "Friend", class: 'btn btn-secondary')
		when "pending"
			content_tag(:div, "Request sent", class: 'btn btn-secondary')
		when "block"
			content_tag(:div, "Blocked!", class: 'btn btn-secondary')
		when nil
			if current_user.request_relationships.any? {|relationship| relationship.user_id == user.id}
				button_to "Accept friend request", accept_request_path, params: {target_id: user.id}
			else
				button_to "Add friend", relationships_path, params: { target_id: user.id }
			end
		else
			content_tag(:div, "nothing", class: 'btn btn-secondary')
		end	
	end
end
