module RatingsHelper
	def stars_images(value)
		star_images = [];

		5.times do |i|
			if value >= 2
				star_images << image_tag("star_full.png")
				value -= 2;
			elsif value == 1
				star_images << image_tag("star_half.png")
				value -= 1;
			else
				star_images << image_tag("star_empty.png")
			end
		end

		star_images.join('').html_safe;
	end
end