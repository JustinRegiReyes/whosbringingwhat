class AddAviFileToUsers < ActiveRecord::Migration
  	def up
		add_attachment :users, :avi
	end

	def down
		remove_attachment :users, :avi
	end
end
