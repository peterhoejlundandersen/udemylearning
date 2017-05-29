class Portfolio < ActiveRecord::Base
	has_many :technologies
	
	include Placeholder
	validates_presence_of :title, :body, :main_image, :thumb_image
	def self.angular 
		where(subtitle: "Angular")
	end

	# A portfolio items is initilized when Portfolio.new is called. 
	after_initialize :set_default

	def set_default
	# Hvis det ikke var ||=, men =, så ville det blive overskrevet, når det var 	
	self.main_image ||= Placeholder.image_generator(height: 400, width: 600)
	self.thumb_image ||= Placeholder.image_generator(height: 350, width: 200)

	end

end
