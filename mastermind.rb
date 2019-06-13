
# Master Mind Game

# Hidden 4 colors in a specific order
# 12 guesses to guess the colors and order
# No blanks, no duplicates colors
# 6 colors; Green, Blue, Red, Yellow, Orange, Purple

# Computer randomly chooses four colors
class Mastermind
	include CodeComparison

	attr_accessor :hidden_code, :win_game, :turn_counter

	def initialize
		@hidden_code = []
		@win_game = false
		@turn_counter = 0
	end

	def numbers_to_colors(number_array)
		number_array.each do |x|
			case
			when number_array[x] == 1
				color = "green"
			when number_array[x] == 2
				color = "blue"
			when number_array[x] == 3
				color = "red"
			when number_array[x] == 4
				color = "yellow"
			when number_array[x] == 5
				color = "orange"
			when number_array[x] == 6
				color = "purple"
			end
			color_array << color
		end
		color_array
	end

	def display_color_choices
		puts "Type the number corresponding to the color and 'enter'"
		puts "1 Green" 
		puts "2 Blue" 
		puts "3 Red"
		puts "4 Yellow"
		puts "5 Orange"
		puts "6 Purple"
	end
end

class ComputerCodePick < Mastermind

	def initialize
		computer_number_array = (1..6).to_a.shuffle.take(4)
		self.hidden_code = numbers_to_colors(computer_number_array)		
	end
end

class HumanCodePick < Mastermind
	attr_accessor :player_color_array

	def initialize
		@player_color_array
	end

	def player_number_pick
		display_color_choices
		4.times do 
			color_number = gets.chomp.to_i
			player_number_array << color_number
		end
		player_color_array = current_game.numbers_to_colors(player_number_array)
	end
end

module CodeComparison

	def compare_code(code_guess, hidden_code)
		if code_guess == hidden_code
			current_game.win_game = true
		elsif hidden_code.include?(code_guess)
			matched_code = []
			code_guess.each do |x|
				if code_guess[x] == hidden_code[x]
					matched_code << code_guess[x]
				else
					matched_code << "x"
				end
			end
			matched_colors_only = hidden_code.select(code_guess)
			puts "MATCHED COLORS: #{matched_colors_only}"
			puts "COMPLETE MATCH: #{matched_code}"
		end
	end
end

player_guess = []

def start_game
	current_game = Mastermind.new
	computer_code = ComputerCodePick.new
	human_code = HumanCodePick.new 
	play_game
end

def play_game
	until current.game.turn_counter == 12 || current.game.win_game == true
		player_guess = human_code.player_number_pick
		current_game.compare_code(player_guess, current_game.hidden_code)
		#maybe move these two lines to their own end_game method
		current_game.win_game == true ? winner_message : current_game.turn_counter += 1
		current_game.turn_counter == 12 ? loser_message : return
	end
	puts "GAME OVER"
end

def winner_message
	puts "Congratulations! you matched the hidden code!"
end

def loser_message
	puts "Sorry you lost. Better luck next time!"
end


puts "Mastermind! Deduce the four color code in 12 guesses."
#puts "Who picks to hidden code? 1 for human; 2 for computer"
#who_pics = gets.chomp.downcase

puts "Possible colors include: "
puts "Green, Blue, Red, Yellow, Orange, Purple"

start_game
