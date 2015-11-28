class User < ActiveRecord::Base
	has_secure_password
	has_many :items
	has_many :categories

	belongs_to :item

	validates :email, :username, :password_digest, presence: true
	validates :email, :username, uniqueness: true

	def self.confirm (params)
		@user = User.find_by({email: params[:username]})
		@user.try(:authenticate, params[:password])
	end
end
