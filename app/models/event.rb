class Event < ActiveRecord::Base
	attr_accessor :owner, :date
	has_many :categories

	has_many :attending_events
	has_many :comments
	belongs_to :user



	# renaming has_many :events throgh: :attending_events alias to attendees
	has_many :attendees, foreign_key: "event_id", through: :attending_events, source: :event

	# paperclip

		# :banner
			has_attached_file :banner, 
				styles: { profile: "600x600" , banner: "200x200>", thumb: "100x100>" },
				:default_url => 'images/bannerplaceholder.png',
				processors: [:papercrop]
			crop_attached_file :banner, :aspect => "4:3"
		  	# validates_attachment :banner, presence: true
		  	validates_attachment :banner,
		  		content_type: { content_type: ["image/jpeg", "image/gif", "image/png", "application/pdf"] }

	def cropping
		!crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
	end

	private
		# runs paperclips reprocess method for crop
		def reprocess_banner
			banner.reprocess!
		end
end
