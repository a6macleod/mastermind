
# Master Mind Game

# Hidden 4 colors in a specific order
# 12 guesses to guess the colors and order
# No blanks, no duplicates colors
# 6 colors; Green, Blue, Red, Yellow, Orange, Purple

class Mastermind

	attr_accessor :hidden_code, :win_game, :turn_counter

	def initialize
		@hidden_code = computer_code_pick
		@win_game = false
		@turn_counter = 0
	end

	def computer_code_pick
		computer_number_array = (1..6).to_a.shuffle.take(4)
		self.hidden_code = numbers_to_colors(computer_number_array)
		puts "ComputerCodePickhidden code #{hidden_code}"	
	end

	def numbers_to_colors(number_array)
		color_array = []
		#color = ""
		number_array.each do |x|
			case
			when x == 1
				color = "green"
			when x == 2
				color = "blue"
			when x == 3
				color = "red"
			when x == 4
				color = "yellow"
			when x == 5
				color = "orange"
			when x == 6
				color = "purple"
			end
			color_array << color
		end
		return color_array
	end

	def display_color_choices
		puts "Type the number corresponding to the color and 'enter'"
		puts "1 - Green" 
		puts "2 - Blue" 
		puts "3 - Red"
		puts "4 - Yellow"
		puts "5 - Orange"
		puts "6 - Purple\n\n"
	end

	def compare_code(code_guess, hidden_code)
		puts "CodeComparison code_guess #{code_guess}"
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

class HumanCodePick < Mastermind
	attr_accessor :player_color_array

	def initialize
		@player_color_array
	end

	def player_number_pick
		display_color_choices
		player_number_array = []
		4.times do 
			color_number = gets.chomp.to_i
			player_number_array << color_number
		end
		player_color_array = numbers_to_colors(player_number_array)
		puts player_color_array
		return player_color_array
	end
end

#player_code_guess = []
#player_choose = []

def start_game
	current_game = Mastermind.new
	human_code = HumanCodePick.new 
	play_game(current_game, human_code)
end

def play_game(current_game, human_code)
	until current_game.turn_counter == 12 || current_game.win_game == true
		player_code_guess = human_code.player_number_pick
		current_game.compare_code(player_code_guess, current_game.hidden_code)
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

puts "\n\n\n--------------------------------------------------------------"
puts "\nMastermind! Deduce the 4 color code within 12 guesses\n"
#puts "Who picks to hidden code? 1 for human; 2 for computer"
#who_pics = gets.chomp.downcase

puts "\nPossible colors include: \n"
puts "Green, Blue, Red, Yellow, Orange, Purple\n"
puts "\n--------------------------------------------------------------\n\n\n"

start_game
