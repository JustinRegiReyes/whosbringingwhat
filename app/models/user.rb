class User < ActiveRecord::Base
	has_secure_password
	has_many :items
	has_many :events
	has_and_belongs_to_many :attending_events

	belongs_to :item

	validates :username, :password_digest, presence: true
	validates :username, uniqueness: true

	def self.confirm (params)
		@user = User.find_by_username(params[:username])
		@user.try(:authenticate, params[:password])
	end
end
