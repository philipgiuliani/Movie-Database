module ApplicationHelper
	
	def flash_class(level)
		case level
		when :notice then "notification success"
		when :alert then "notification error"
		end
	end

end