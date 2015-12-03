class Event < ActiveRecord::Base
	has_many :categories

	has_one :attending_event
	belongs_to :user

end
