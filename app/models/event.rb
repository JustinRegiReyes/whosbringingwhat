class Event < ActiveRecord::Base
	attr_accessor :owner, :date
	has_many :categories, dependent: :destroy

	has_many :attending_events, dependent: :destroy
	has_many :comments, dependent: :destroy
	belongs_to :user

	validates :title, :search_key, :date_start, :time_start, :address, :city, :zipcode, :state, :where, :highlights, :description, presence: true



	# renaming has_many :events throgh: :attending_events alias to attendees
	has_many :attendees, foreign_key: "event_id", through: :attending_events, source: :event

	# paperclip

  		# :photo
			has_attached_file :photo, 
				styles: { large: "600x600" , medium: "300x300", thumb: "100x100" },
				:default_url => 'bannerplaceholder.svg',
				processors: [:papercrop]
			crop_attached_file :photo, :aspect => "1:1"
		  	# validates_attachment :photo, presence: true
		  	validates_attachment :photo,
		  		content_type: { content_type: ["image/jpeg", "image/gif", "image/png", "application/pdf"] }

	  		after_update :reprocess_photo, :if => :photo_cropping

		# :banner
			has_attached_file :banner, 
				styles: { large: "1000X600" , medium: "800x500", thumb: "300x180" },
				:default_url => 'bannerplaceholder.svg',
				processors: [:papercrop]
			crop_attached_file :banner, :aspect => "8:5"
		  	# validates_attachment :banner, presence: true
		  	validates_attachment :banner,
		  		content_type: { content_type: ["image/jpeg", "image/gif", "image/png", "application/pdf"] }

	  		after_update :reprocess_banner, :if => :banner_cropping

	def photo_cropping
		!photo_crop_x.blank? && !photo_crop_y.blank? && !photo_crop_w.blank? && !photo_crop_h.blank?
	end

	def banner_cropping
		!banner_crop_x.blank? && !banner_crop_y.blank? && !banner_crop_w.blank? && !banner_crop_h.blank?
	end

	def attending_guests
		self.attending_events.where({going: true})
	end

	private
		# runs paperclips reprocess method for crop
		def reprocess_banner
			banner.reprocess!
		end

		# runs paperclips reprocess method for crop
		def reprocess_photo
			photo.reprocess!
		end
end
