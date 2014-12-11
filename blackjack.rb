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
system 'clear'
puts "Welcome to the Jack is Black Casino - let's play some Blackjack!"
puts "What is your name?"
name = gets.chomp
player_money = 250
puts "Welcome #{name}!"

loop do
  # Initialize Deck
  suits = ['♠', '♥', '♦', '♣']
  cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  deck = suits.product(cards)
  deck.shuffle!
  # Bet
  system 'clear'
  puts "You have \$#{player_money} to play with"
  puts "#{name}, minimum bet is $5. How much of your \$#{player_money} would you like to wager? (Numbers only, no '$' or decimals)"
  bet = gets.chomp.to_i

  if bet < 5
    puts " "
    puts "Come on #{name}, we have standards here. Bet at least the minimum!"
    puts " "
    puts "#{name}, minimum bet is $5. How much of your \$#{player_money} would you like to wager? (Numbers only, no '$' or decimals)"
    bet = gets.chomp.to_i
  end 

  if bet > player_money
    puts " "
    puts "Whoa there high roller - you only have \$#{player_money} to play with!"
    puts " "
    puts "#{name}, minimum bet is $5. How much of your \$#{player_money} would you like to wager? (Numbers only, no '$' or decimals)"
    bet = gets.chomp.to_i
  end

  system 'clear'
  puts "Ok #{name}, #{bet} it is! Let's deal!"

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

  sleep 1.5

  # If player has BJ and dealer doesn't
  if (playertotal == 21) && (dealertotal <= 20)
    player_money = player_money + (bet * 1.5)
    system 'clear'
    puts "BLACKJACK!! You win 1.5X your bet! You now have \$#{player_money}!!"
    puts "Do you want to play another hand (Y or N)?"
    black_win = gets.chomp.downcase
    break if black_win != 'y'
    redo if black_win == 'y' 
  end

  # If both have BJ
  if (playertotal == 21) && (dealertotal == 21)
    system 'clear'
    puts "You both got blackjacks.. so its a PUSH! You still have \$#{player_money}!!"
    puts "Do you want to play another hand (Y or N)?"
    push = gets.chomp.downcase
    break if push != 'y'
    redo if push == 'y'
  end 

  #If dealer has BJ and player doesn't
  if (dealertotal == 21) && (playertotal <= 20)
    puts " "
    puts "Checking for blackjack...."
    sleep 1.0
    player_money = player_money - bet
    system 'clear'
    puts "SHOOT - Dealer got BLACKJACK.. Better luck next hand! You still have \$#{player_money}!!"
    puts "Do you want to play another hand (Y or N)?"
    jack_lose = gets.chomp.downcase
    break if jack_lose != 'y'
    redo if jack_lose == 'y'
  end

  # Player Hand
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
      system 'clear'
  		playercards << deck.pop
  		playertotal = calculate_total(playercards)
      puts "dealer is showing #{dealercards[1]}"
      puts " "
  		puts "#{name} now has #{playercards} -- with a value of #{playertotal}"
  	elsif player_choice == '2'
  		puts "#{name} has chosen to stand with a value of #{playertotal}"
  	  break
  	end
  end

  if	playertotal >= 22
      player_money = (player_money - bet)
      sleep 1.0 
      system 'clear'
  		puts "#{name} BUSTED!! You lose \$#{bet}! You now have \$#{player_money} to play with."
      puts "Do you want to play another hand (Y or N)?"
      player_bust = gets.chomp.downcase
      break if player_bust != 'y'
      redo if player_bust == 'y' 
  end

  # Dealer Hand
  sleep 1.0
  puts " "
  puts "Dealer flipped a #{dealercards[0]} -- She has a value of #{dealertotal}"
  sleep 1.0
  puts " "

  while dealertotal < 17
    dealercards << deck.pop
  	dealertotal = calculate_total(dealercards)
  	puts "Dealer now has #{dealercards} -- with a total of #{dealertotal}"
    sleep 1.0
  end

  if dealertotal >= 22
      player_money = (player_money + bet)
      sleep 1.0
      system 'clear'
      puts "Dealer BUSTED!! #{name} WINS!!"
      puts "#{name}, you now have \$#{player_money} to play with!"
      puts "Do you want to play another hand (Y or N)?"
      dealer_b = gets.chomp.downcase
      break if dealer_b != 'y'
      redo if dealer_b == 'y'
  end 

  sleep 1.5
  system 'clear'

  # Declaring Winner or Loser
  if (playertotal > dealertotal) && (playertotal <= 21) || (dealertotal > 21)
    puts "CONGRATS #{name}! Your #{playertotal} beats her #{dealertotal}.. YOU WIN!!"
    player_money = (bet) + player_money
    puts "You won \$#{bet}! You now have \$#{player_money} to play with!" 
  elsif (dealertotal > playertotal) && (dealertotal <= 21) || (playertotal > 21)
    puts "SORRY #{name}, but her #{dealertotal} beats your #{playertotal}.. YOU LOSE!"
    player_money = (player_money - bet) 
    puts "You lost \$#{bet}! You have \$#{player_money} left."
  elsif (playertotal == dealertotal) && (dealertotal <= 21) && (playertotal <= 21)
  	puts "it's a PUSH!"
    puts "You have \$#{player_money} left to play with!"
  else
    puts "You both BUSTED! so the dealer WINS"
    player_money = (player_money - bet) 
    puts "You lost \$#{bet}! You have \$#{player_money} left."
  end

  if player_money <= 0 
    puts " "
    puts "You are BANKRUPT!"
    puts "Do you want to re-up your $250 at the ATM? (Y or N)"
    player_money = player_money + 250
    money = gets.chomp.downcase
    break if money != 'y'
    redo if money == 'y'
  end

  puts "Do you want to play another hand (Y or N)?"
  break if gets.chomp.downcase != 'y'
end

puts "Thanks for playing at the Jack is Black Casino!!"
sleep 1.0




