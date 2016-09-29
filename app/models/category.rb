class Category < ActiveRecord::Base
	has_many :items, dependent: :destroy
	belongs_to :event

	def enough_items?
		if  self.items.length >= self.needed
			return true
		else
			return false
		end
	end
end
