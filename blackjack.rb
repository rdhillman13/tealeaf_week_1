require 'pry'

# Blackjack

# Welcome and ask name
# Deal cards

# calculate/print player total

# loop while  
	# player hits
	# calculate total
# elsif
	# player busts
	# player loses
# else 
	# player stays

# flip down card
# calculate/print dealer total

# loop while 
	# dealer hits
	# calculate total
# elsif
	# dealer busts
	# dealer loses
# else 
	# dealer stays (dealer has to stay at 17 and has to hit if lower than 17)

# announce winner
# play another hand?

# ---------------------------

def calculate_total(cards) 
  arr = cards.map{|e| e[1] }

  total = 0
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0 # J, Q, K
      total += 10
    else
      total += value.to_i
    end
  end

  #correct for Aces if '11' bust
  arr.select{|e| e == "A"}.count.times do
    total -= 10 if total > 21
  end

  total
end


# Program -------------------

suits = ['♠', '♥', '♦', '♣']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suits.product(cards)
deck.shuffle!

system 'clear'
puts "Welcome to the Jack is Black Casino - let's play some Blackjack!"
puts "What is your name?"
name = gets.chomp
puts "Ok #{name}, Let's deal!"

loop do
  # Deal cards
  playercards = []
  dealercards = []

  playercards << deck.pop
  dealercards << deck.pop
  playercards << deck.pop
  dealercards << deck.pop

  dealertotal = calculate_total(dealercards)
  playertotal = calculate_total(playercards)

  sleep 1.5

  puts "dealer is showing #{dealercards[1]}"
  puts " "
  puts "#{name} has #{playercards} -- with a value of #{playertotal} "

  while playertotal < 21
  	puts 'Type 1 to HIT'
  	puts 'Type 2 to STAND'
    puts "---------------"
  	player_choice = gets.chomp.to_s
  	
  	if player_choice > '2'
  		puts "You must enter a '1', or a '2'."
  		puts 'Type 1 to HIT'
  		puts 'Type 2 to STAND'
      puts "---------------"
  		player_choice = gets.chomp.to_s
  	end
    
    if player_choice == '1'
  		playercards << deck.pop
  		playertotal = calculate_total(playercards)
  		puts "#{name} now has #{playercards} -- with a value of #{playertotal}"
  	elsif player_choice == '2'
  		puts "#{name} has chosen to stand with a value of #{playertotal}"
  		break
  	end
  end

  if	playertotal > 21
  		puts "#{name} BUSTED!!"
  end

  sleep 1.0
  puts " "
  puts "Dealer flipped a #{dealercards[0]} -- She has a valuse of #{dealertotal}"
  sleep 1.0
  puts " "

  while dealertotal < 17
  	dealercards << deck.pop
  	dealertotal = calculate_total(dealercards)
  	puts "Dealer now has #{dealercards} -- with a total of #{dealertotal}"
  end

  if dealertotal > 21
      puts "Dealer BUSTED!! #{name} WINS!!"
  end

  sleep 2.0
  system 'clear'

  # Declaring Winner or Loser
  if dealertotal > playertotal
  	puts "SORRY #{name}, but her #{dealertotal} beats your #{playertotal}.. YOU LOSE!"
  elsif playertotal > dealertotal
  	puts "CONGRATS #{name}! Your #{playertotal} beats her #{dealertotal}.. YOU WIN!!"
  elsif playertotal == dealertotal
  	puts "it's a PUSH!"
  end

  puts "Do you want to play another hand (Y or N)?"
  break if gets.chomp.downcase != 'y'
end

puts "Thanks for playing at the Jack is Black Casino!!"





