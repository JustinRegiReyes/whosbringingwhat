module ItemsHelper
	def rando_item
		poker_set =  {
			title: "Poker Set",
			description: "1000 chips. Few decks of cards. "
		}
		mac_n_cheese = {
			title: "Mac N Cheese",
			description: "My famous baked mac n' cheese. I'll bring about 6 servings worth. "
		}
		cups = {
			title: "Cups",
			description: "72 red cups. 3 packs of 24."
		}
		bourbon = {
			title: "Buffalo Trace",
			description: "Smooth 90 proof bourbon. Hints of toffee and vanilla."
		}
		beer = {
			title: "Beer",
			description: "2 6pack boxes of Guinness! Mmmm."
		}
		chips = {
			title: "Ruffles",
			description: "I'll bring the sour cream n onion and cheddar!"
		}
		streamers = {
			title: "Streamers",
			description: "Different colored streamers to hang on the wall. I have about 12! :)"
		}
		cheesecake = {
			title: "Cheesecake",
			description: "16in. Caramel cheesecake. I'll try to make it bigger if more people end up coming."
		}
		charcoal = {
			title: "Charcoal",
			description: "The big bag of charcoal from Smart N' Final! It may not be name brand but there sure is a lot!"
		}
		items = [poker_set, mac_n_cheese, cups, bourbon, beer, chips, streamers, cheesecake, charcoal]
		return items.sample
	end
end
