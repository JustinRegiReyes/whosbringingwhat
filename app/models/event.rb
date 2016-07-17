class Event < ActiveRecord::Base
	attr_accessor :owner, :date
	has_many :categories

	has_many :attending_events
	belongs_to :user



	# renaming has_many :events throgh: :attending_events alias to attendees
	has_many :attendees, foreign_key: "event_id", through: :attending_events, source: :event
end
