class User < ActiveRecord::Base
	has_many :items
	has_many :events
	has_many :attending_events

	has_secure_password
	validates :username, :password_digest, presence: true
	validates :username, uniqueness: true

	def self.confirm (params)
		@user = User.find_by_username(params[:username])
		@user.try(:authenticate, params[:password])
	end
end
