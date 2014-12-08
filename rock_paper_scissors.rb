CHOICES = {'r' => 'Rock', 'p' => 'Paper', 's' => 'Scissors' }
puts "Whats up!? Let's play Rock, Paper, Scissors!"

# Defining the possible winning messages
def win(pick_w)
  case pick_w 
  when 'r' 
    puts "You: Rock | Me: Scissors"
  when 'p'
    puts "you: Paper | Me: Rock"
  when 's'
    puts "you: Scissors | Me: Paper"
  end
end

# Defining the possible losing messages
def loss(pick_l)
  case pick_l 
  when 'r' 
    puts "You: Rock | Me: Paper"
  when 'p'
    puts "you: Paper | Me: Scissors"
  when 's'
    puts "you: Scissors | Me: Rock"
  end
end

loop do 
  # Player choice
  begin # loop to validate user input
    puts "Choose one: r, p or s?"
    user_choice = gets.chomp.downcase
  end until CHOICES.keys.include?(user_choice) # Loop until the user_choice is == a key in the CHOICES hash

  # Computer choice (random)
  computer_choice = CHOICES.keys.sample

  if user_choice == computer_choice
    puts "it's a tie!"
  elsif (user_choice == 'r' && computer_choice == 's') || (user_choice == 'p' && computer_choice == 'r') || (user_choice == 's' && computer_choice == 'p')
    win(user_choice)
    puts 'you win!'
  elsif (user_choice == 'r' && computer_choice == 'p') || (user_choice == 'p' && computer_choice == 's') || (user_choice == 's' && computer_choice == 'r')
    loss(user_choice)
    puts 'you lose!'
  end

  puts 'play again? (y/n)'
  break if gets.chomp.downcase != 'y'
end

puts 'Thanks for playing!' 
