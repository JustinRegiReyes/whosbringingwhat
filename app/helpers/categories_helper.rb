module CategoriesHelper
	def create_categories(categories, eventId, current_user_id)
		created_categories = []
		categories.each do |category|
			category[:event_id] = eventId
			category[:user_id] = current_user_id
			c = Category.create({
				event_id: eventId,
				user_id: current_user_id,
				title: category[:title],
				needed: category[:needed].to_i,
				description: category[:description]
				})
			created_categories.push(c)
		end
		return created_categories
	end

	def categories_delete_items(categories)
		categories.each do |c|
			c.items.destroy_all
		end
	end

	def validate_categories(categories, event)
		categories.each do |category|
			c = Category.new({
				title: category[:title],
				needed: category[:needed].to_i,
				description: category[:description]
				})
			if c.valid? == false
				event.errors.add("Categories:", " Check length of attributes for categories")
				return false
			end
		end
		return true
	end
end
