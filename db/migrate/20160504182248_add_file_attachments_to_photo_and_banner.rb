class AddFileAttachmentsToPhotoAndBanner < ActiveRecord::Migration
  	def up
		add_attachment :events, :photo
		add_attachment :events, :banner
	end

	def down
		remove_attachment :events, :photo
		remove_attachment :events, :photo
	end
end
