# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create({username: "Jstn", password: "qwe"})

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
		date_start: thisMonth + "-4",
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
		date_start: thisMonth + "-13",
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
		date_start: thisMonth + "-27",
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
		date_start: nextMonth + "-2",
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

categories = [
	{
		title: "Utensils",
		description: "Utensils for food",
		needed: 3
	},
	{
		title: "Snacks",
		description: "Chips. Drinks. Cookies. Dranks.",
		needed: 6
	},
	{
		title: "Games",
		description: "Board games, laptop for steam? Anything really.",
		needed: 2
	},
	{
		title: "Misc",
		description: "Anything you think we might need",
		needed: 2
	},
	{
		title: "Food",
		description: "More fulfilling things to eat.",
		needed: 4
	},
	{
		title: "Just Pitching In",
		description: "If you cant bring anything and just want to pitch in let me know. So I can make extra food for your pitch in.",
		needed: 0
	}
]

items = [
	{
		title: "Item 1",
		description: "Bacon ipsum dolor amet strip steak drumstick fatback, kielbasa boudin t-bone ribeye. Jerky ball tip pork bresaola landjaeger biltong kielbasa jowl doner strip steak. Pork belly capicola cow corned beef tail pastrami venison ribeye salami chicken. Beef ham spare ribs sirloin pig tri-tip bresaola pork chop swine. Prosciutto frankfurter shank filet mignon pork chop hamburger beef ribs t-bone landjaeger pork spare ribs."
	},
	{
		title: "Item 2",
		description: "Bacon ipsum dolor amet strip steak drumstick fatback, kielbasa boudin t-bone ribeye. Jerky ball tip pork bresaola landjaeger biltong kielbasa jowl doner strip steak. Pork belly capicola cow corned beef tail pastrami venison ribeye salami chicken. Beef ham spare ribs sirloin pig tri-tip bresaola pork chop swine. Prosciutto frankfurter shank filet mignon pork chop hamburger beef ribs t-bone landjaeger pork spare ribs."
	},
	{
		title: "Item 3",
		description: "Bacon ipsum dolor amet strip steak drumstick fatback, kielbasa boudin t-bone ribeye. Jerky ball tip pork bresaola landjaeger biltong kielbasa jowl doner strip steak. Pork belly capicola cow corned beef tail pastrami venison ribeye salami chicken. Beef ham spare ribs sirloin pig tri-tip bresaola pork chop swine. Prosciutto frankfurter shank filet mignon pork chop hamburger beef ribs t-bone landjaeger pork spare ribs."
	}
]

comments = ["Bacon ipsum dolor amet biltong spare ribs sausage, flank tongue pork hamburger. Landjaeger pork belly spare ribs strip steak corned beef andouille fatback pastrami tenderloin shoulder turducken turkey boudin hamburger. Pork belly tri-tip pork chop, tail shank landjaeger shankle alcatra turducken ball tip frankfurter beef ham hock. Rump t-bone sausage chuck, turkey frankfurter porchetta brisket salami shank meatloaf corned beef filet mignon kielbasa short loin. Ball tip meatloaf cow, meatball hamburger venison flank capicola. Pancetta capicola bacon, venison alcatra drumstick hamburger leberkas beef ribs beef filet mignon ham.", "Bacon ipsum dolor amet biltong spare ribs sausage, flank tongue pork hamburger. Landjaeger pork belly spare ribs strip steak corned beef andouille fatback pastrami tenderloin shoulder turducken turkey boudin hamburger. Pork belly tri-tip pork chop, tail shank landjaeger shankle alcatra turducken ball tip frankfurter beef ham hock. Rump t-bone sausage chuck, turkey frankfurter porchetta brisket salami shank meatloaf corned beef filet mignon kielbasa short loin.", "Bacon ipsum dolor amet landjaeger pancetta shankle meatloaf, chuck sausage porchetta turducken pork loin capicola beef sirloin. Pastrami beef pork short ribs jerky andouille pork chop shank turducken. Jerky meatball ham hock picanha ground round pork belly meatloaf.", "Bacon ipsum dolor amet landjaeger pancetta shankle meatloaf, chuck sausage porchetta turducken pork loin capicola beef sirloin. Pastrami beef pork short ribs jerky andouille pork chop shank turducken. Jerky meatball ham hock picanha ground round pork belly meatloaf. Hamburger capicola jerky turducken shank boudin shoulder prosciutto ribeye bacon spare ribs tail pancetta tri-tip. Strip steak doner venison, kevin chicken jerky bresaola tri-tip leberkas jowl cow tail spare ribs short ribs. Does your lorem ipsum text long for something a little meatier? Give our generator a try… it’s tasty!"]

created_events = Event.create(events)

created_events.each do |event|
	comments.each do |comment|
		c = Comment.create({post: comment})
		event.comments << c
		user.comments << c
	end
	categories.each do |category|
		c = Category.create({title: category[:title], description: category[:description], needed: category[:needed]})
		event.categories << c
		items.each do |item|
			i = Item.create({title: item[:title], description: item[:description]})
			c.items << i
			user.items << i
		end
	end
end

user.going_tos << created_events.last



