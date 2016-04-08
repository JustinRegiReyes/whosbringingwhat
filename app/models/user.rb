class User < ActiveRecord::Base
	has_many :items
	# renaming has_many :events alias to created_events
	has_many :created_events, foreign_key: "user_id", class_name: "Event"
	has_many :attending_events

	# renaming has_many :events throgh: :attending_events alias to going_tos
	has_many :going_tos, foreign_key: "user_id", through: :attending_events, source: :event

	has_secure_password
	validates :username, :password_digest, presence: true
	validates :username, uniqueness: true

	def self.confirm (params)
		@user = User.find_by_username(params[:username])
		@user.try(:authenticate, params[:password])
	end
end
