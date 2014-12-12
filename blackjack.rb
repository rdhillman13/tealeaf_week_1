def calculate_total(cards) 
  array = cards.map{|e| e[1] }

  total = 0
  array.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0 # J, Q, K
      total += 10
    else
      total += value.to_i
    end
  end

  #correct for Aces if '11' bust
  array.select{|e| e == "A"}.count.times do
    total -= 10 if total > 21
  end

  total
end

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
  player_cards = []
  dealer_cards = []

  player_cards << deck.pop
  dealer_cards << deck.pop
  player_cards << deck.pop
  dealer_cards << deck.pop

  dealer_total = calculate_total(dealer_cards)
  player_total = calculate_total(player_cards)

  sleep 1.5

  puts "dealer is showing #{dealer_cards[1]}"
  puts " "
  puts "#{name} has #{player_cards} -- with a value of #{player_total} "

  sleep 1.5

  # If player has BJ and dealer doesn't
  if (player_total == 21) && (dealer_total <= 20)
    player_money = player_money + (bet * 1.5)
    system 'clear'
    puts "BLACKJACK!! You win 1.5X your bet! You now have \$#{player_money}!!"
    puts "Do you want to play another hand (Y or N)?"
    black_win = gets.chomp.downcase
    break if black_win != 'y'
    redo if black_win == 'y' 
  end

  # If both have BJ
  if (player_total == 21) && (dealer_total == 21)
    system 'clear'
    puts "You both got blackjacks.. so its a PUSH! You still have \$#{player_money}!!"
    puts "Do you want to play another hand (Y or N)?"
    push = gets.chomp.downcase
    break if push != 'y'
    redo if push == 'y'
  end 

  #If dealer has BJ and player doesn't
  if (dealer_total == 21) && (player_total <= 20)
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
  while player_total < 21
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
  		player_cards << deck.pop
  		player_total = calculate_total(player_cards)
      puts "dealer is showing #{dealer_cards[1]}"
      puts " "
  		puts "#{name} now has #{player_cards} -- with a value of #{player_total}"
  	elsif player_choice == '2'
  		puts "#{name} has chosen to stand with a value of #{player_total}"
  	  break
  	end
  end

  if	player_total >= 22
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
  puts "Dealer flipped a #{dealer_cards[0]} -- She has a value of #{dealer_total}"
  sleep 1.0
  puts " "

  while dealer_total < 17
    dealer_cards << deck.pop
  	dealer_total = calculate_total(dealer_cards)
  	puts "Dealer now has #{dealer_cards} -- with a total of #{dealer_total}"
    sleep 1.0
  end

  if dealer_total >= 22
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
  if (player_total > dealer_total) && (player_total <= 21) || (dealer_total > 21)
    puts "CONGRATS #{name}! Your #{player_total} beats her #{dealer_total}.. YOU WIN!!"
    player_money = (bet) + player_money
    puts "You won \$#{bet}! You now have \$#{player_money} to play with!" 
  elsif (dealer_total > player_total) && (dealer_total <= 21) || (player_total > 21)
    puts "SORRY #{name}, but her #{dealer_total} beats your #{player_total}.. YOU LOSE!"
    player_money = (player_money - bet) 
    puts "You lost \$#{bet}! You have \$#{player_money} left."
  elsif (player_total == dealer_total) && (dealer_total <= 21) && (player_total <= 21)
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




