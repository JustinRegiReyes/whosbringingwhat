class Category < ActiveRecord::Base
	has_many :items
	belongs_to :event
end
