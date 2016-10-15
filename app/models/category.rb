class Category < ActiveRecord::Base
	has_many :items, dependent: :destroy
	belongs_to :event

	# validations
		validates :title, presence: true, length: {maximum: 12}
		validates :description, presence: true, length: {maximum: 300}

	def enough_items?
		if  self.items.length >= self.needed
			return true
		else
			return false
		end
	end
end
