# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create({username: "qwe", password: "qwe"})

prevTwoMonth = (Time.now - 2.month).strftime("%Y-%m")
prevMonth = (Time.now - 1.month).strftime("%Y-%m")
thisMonth = (Time.now).strftime("%Y-%m")
nextMonth = (Time.now + 1.month).strftime("%Y-%m")
nextTwoMonth = (Time.now + 2.month).strftime("%Y-%m")
timeStart = Time.now.strftime("%I:%M")
timeEnd = (Time.now + 3.hour).strftime("%I:%M")
# puts "prevTwoMonth", prevTwoMonth.strftime("%Y-%m")
# puts "prevMonth", prevMonth.strftime("%Y-%m")
# puts "thisMonth", thisMonth.strftime("%Y-%m")
# puts "nextMonth", nextMonth.strftime("%Y-%m")
# puts "nextTwoMonth", nextTwoMonth.strftime("%Y-%m")

events = [
	{
		title: "Camping",
		description: "We be going campin' yall.",
		address: "Yosemite Falls",
		city: "Yosemite Village",
		zipcode: "95389",
		state: "Ca",
		country: "United States",
		where: "Idk somewhere near Yosemite. Uhhh it's at the campgrounds.",
		highlights: "Chillin. That's it.",
		date_start: nextMonth + "-3",
		date_end: nextMonth + "-7",
		time_start: timeStart,
		time_end: timeEnd,
		user_id: user.id
	},
	{
		title: "Board Game Night",
		description: "Board GAAAMEZ. Let there be salt.",
		address: "1something Terazzo",
		city: "American Canyon",
		zipcode: "94591",
		state: "Ca",
		country: "United States",
		where: "Roro's house.",
		highlights: "Try and bring some board games if you can.",
		date_start: thisMonth + "-16",
		time_start: timeStart,
		time_end: timeEnd,
		user_id: user.id
	},
	{
		title: "Texas Hold Em' Pinkies High",
		description: "Poker at my place with some tea! Feel free to bring some snacks or other food if you want.",
		address: "123 Garthe Street",
		city: "Vallejo",
		zipcode: "94591",
		state: "Ca",
		country: "United States",
		where: "Cortezu Home Base",
		highlights: "Bring yall poker faces!",
		date_start: thisMonth + "-23",
		time_start: timeStart,
		time_end: timeEnd,
		user_id: user.id
	},
	{
		title: "Keep Talking and Nobody Explodes",
		description: "READ THE TITLE BOIZ. GET YO MANUALS READY. ROCHELLE GET COMPLICATED WIRES READY. LETS DO DIS. BEEP BEEEP BEP BEEEEP  - BEEEP",
		address: "133 Cypress Ave",
		city: "Vallejo",
		zipcode: "94590",
		state: "Ca",
		country: "United States",
		where: "Reyes House of Chicken and Wombos",
		highlights: "Bring yall poker faces!",
		date_start: thisMonth + "-28",
		time_start: timeStart,
		time_end: timeEnd,
		user_id: user.id
	},
	{
		title: "Friday Night Fights",
		description: "Bring your sticks. Bring your fight pads.",
		address: "123 Cypress Circle",
		city: "Vallejo",
		zipcode: "94591",
		state: "Ca",
		country: "United States",
		where: "Neils House",
		highlights: "Bring your own food if you want. Or we can go get something before the night starts.",
		date_start: nextMonth + "-10",
		time_start: timeStart,
		time_end: timeEnd,
		user_id: user.id
	},
	{
		title: "Lets Watch a Movie!!",
		description: "Lets watch a movie!!",
		address: "123 Garthe St.",
		city: "Vallejo",
		zipcode: "94591",
		state: "Ca",
		country: "United States",
		where: "Cortezu Home Base",
		highlights: "Let's watch a movie!!",
		date_start: nextMonth + "-18",
		time_start: timeStart,
		time_end: timeEnd,
		user_id: user.id
	},
	{
		title: "Pokemon lessssGOOO",
		description: "Lets walk around my place and catch some pokes?",
		address: "?",
		city: "American Canyon",
		zipcode: "94591",
		state: "Ca",
		country: "United States",
		where: "Roro's House",
		highlights: "We can get food after or cook. Whatever you guys want",
		date_start: nextTwoMonth + "-1",
		time_start: timeStart,
		time_end: timeEnd,
		user_id: user.id
	},
	{
		title: "Test Event",
		description: "Testing",
		address: "Testing",
		city: "American Canyon",
		zipcode: "94591",
		state: "Ca",
		country: "United States",
		where: "Roro's House",
		highlights: "Testing. Testing. Testing. Testing. Testing.",
		date_start: nextTwoMonth + "-28",
		time_start: timeStart,
		time_end: timeEnd,
		user_id: user.id
	}
]

created_events = Event.create(events)
user.going_tos << created_events.last

user.save



