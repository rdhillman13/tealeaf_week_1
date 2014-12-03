#Calculator

def say(m)
	puts "-- #{m} --"
end

say "Whats up!? Want to calculate some basic numbers?"
say "What do you want the first number to be?"
num1 = gets.chomp

while num1 != num1.to_i.to_s do
  puts "That is not a number!"
  num1 = gets.chomp
end

say "What function would you like to perform? (+, -, *, /)"
operator = gets.chomp

while operator != "+"; "-"; "*"; "/"
	puts "Please input a valid operator"
	puts "What function would you like to perform? (+, -, *, /)"
	operator = gets.chomp
end

say "What is the second number?"
num2 = gets.chomp

while num2 != num2.to_i.to_s do
  puts "That is not a number!"
  num2 = gets.chomp
end

if operator == "+"
	result = num1.to_i + num2.to_i
elsif operator == '-'
	result = num1.to_i - num2.to_i
elsif operator == '*'
	result = num1.to_i * num2.to_i
elsif operator == '/'
	result = num1.to_i / num2.to_f
end

puts "-- Result is #{result} --"

