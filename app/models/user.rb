class User < ActiveRecord::Base
	before_save :default_values
	attr_accessor :event_target

	has_many :comments
	has_many :items
	# renaming has_many :events alias to created_events
	has_many :created_events, foreign_key: "user_id", class_name: "Event"
	has_many :attending_events
	has_many :notifications

	# renaming has_many :events throgh: :attending_events alias to going_tos
	has_many :going_tos, foreign_key: "user_id", through: :attending_events, source: :event
	has_many :friendships
	has_many :friends, -> {where(friendships: {accepted: true})}, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, -> {where(friendships: {accepted: true})}, :through => :inverse_friendships, :source => :user

	has_secure_password
	validates :username, :password_digest, :email, presence: true
	validates_uniqueness_of :email, :case_sensitive => false

	# paperclip

		# :on_hand_photo
			has_attached_file :avi, 
				styles: { profile: "600x600" , avi: "200x200>", thumb: "100x100>" },
				:default_url => 'aviplaceholder.png',
				processors: [:papercrop]
			crop_attached_file :avi, :aspect => "1:1"
		  	# validates_attachment :avi, presence: true
		  	validates_attachment :avi,
		  		content_type: { content_type: ["image/jpeg", "image/gif", "image/png", "application/pdf"] }

			after_update :reprocess_avi, :if => :cropping
	# methods
	def self.confirm (params)
		@user = User.find_by_email(params[:email])
		@user.try(:authenticate, params[:password])
	end

	def default_values
		# binding.pry
		# self.avi.url = "test" unless (self.avi.url != "/avis/original/missing.png")
	end

	def cropping
		!avi_crop_x.blank? && !avi_crop_y.blank? && !avi_crop_w.blank? && !avi_crop_h.blank?
	end

	def avi_url
        self.avi.url(:medium)
    end

    def attendance_status
    	# hunts down the key in the attending_event assigned
    	# in the all_guests method in the events controller
    	self.event_target.attributes.key(true)
    end

    def is_friend?(friend)
    	myFriend = self.friends.find_by_id(friend.id)
    	theirFriend = self.inverse_friends.find_by_id(friend.id)
    	if myFriend == nil && theirFriend == nil
    		return false
		else
			return true
    	end
    end

    def friendship_pending?(friend)
    	friendship = self.friendships.find_by_friend_id(friend.id)
    	if friendship == nil
    		return false
    	elsif friendship.pending == true
    		return true
    	else
    		return false
    	end
    end

    def self.by_username(username)
    	return where("") unless username.present?
			
		return where("lower(username) = ?", username.downcase)
    end

    def self.by_email(email)
    	return where("") unless email.present?

		return where("lower(email) = ?", email.downcase)
    end

    def update_password(newpass, retypenewpass)
    	if newpass.empty? == true || retypenewpass.empty? == true
    		errors.add("New Password:", " Both password fields must be filled")
    	elsif newpass == retypenewpass
    		self.password = newpass
    		self.save
    		return true
    	else
    		errors.add("New Password:", " Must match to save password change")
    		return false
    	end
    end

    private
		# runs paperclips reprocess method for crop
		def reprocess_avi
			avi.reprocess!
		end
end
