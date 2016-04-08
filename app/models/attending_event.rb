class AttendingEvent < ActiveRecord::Base
	belongs_to :users
	belongs_to :event
end
