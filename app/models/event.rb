class Event < ActiveRecord::Base
	has_many :categories

	has_many :attending_events
	has_many :users, through: :attending_events
	belongs_to :user
end
