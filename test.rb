# ------------------------------
system 'clear'
puts "Welcome to the Jack is Black Casino - let's play some Blackjack!"
puts "What is your name?"
name = gets.chomp

puts "Ok #{name}, Let's deal!"

deal_player_cards
deal_dealer_downcard
deal_dealer_upcard

while
	player_choice
	check_winner
	dealer_choce
	check_winner
	winner = check_winner(cards)
end	