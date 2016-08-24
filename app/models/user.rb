class User < ActiveRecord::Base
	before_save :default_values
	attr_accessor :event_target

	has_many :comments
	has_many :items
	# renaming has_many :events alias to created_events
	has_many :created_events, foreign_key: "user_id", class_name: "Event"
	has_many :attending_events

	# renaming has_many :events throgh: :attending_events alias to going_tos
	has_many :going_tos, foreign_key: "user_id", through: :attending_events, source: :event

	has_secure_password
	validates :username, :password_digest, presence: true
	validates :username, uniqueness: true

	# paperclip

		# :on_hand_photo
			has_attached_file :avi, 
				styles: { profile: "600x600" , avi: "200x200>", thumb: "100x100>" },
				:default_url => 'images/aviplaceholder.png',
				processors: [:papercrop]
			crop_attached_file :avi, :aspect => "3:4"
		  	# validates_attachment :avi, presence: true
		  	validates_attachment :avi,
		  		content_type: { content_type: ["image/jpeg", "image/gif", "image/png", "application/pdf"] }

			after_update :reprocess_avi, :if => :cropping
	# methods
	def self.confirm (params)
		@user = User.find_by_username(params[:username])
		@user.try(:authenticate, params[:password])
	end

	def default_values
		# binding.pry
		# self.avi.url = "test" unless (self.avi.url != "/avis/original/missing.png")
	end

	def cropping
		!crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
	end

	def avi_url
        self.avi.url(:medium)
    end

    def attendance_status
    	# hunts down the key in the attending_event assigned
    	# in the all_guests method in the events controller
    	self.event_target.attributes.key(true)
    end

    private
		# runs paperclips reprocess method for crop
		def reprocess_avi
			avi.reprocess!
		end
end
