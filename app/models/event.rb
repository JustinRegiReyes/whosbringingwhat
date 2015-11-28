class Event < ActiveRecord::Base
	has_many :categories

	belongs_to :user
end
