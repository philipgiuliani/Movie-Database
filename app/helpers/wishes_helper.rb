module WishesHelper
	def status_values_translated(array)
		values = []
		array.each do |value|
			values << [t("activerecord.attributes.wish.statuses.#{value}"), value]
		end
		values
	end

	def priority_values_translated(array)
		values = []
		array.each do |value|
			values << [t("activerecord.attributes.wish.priorities.#{value}"), value]
		end
		values
	end
end