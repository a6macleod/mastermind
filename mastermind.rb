
# Master Mind Game

# Hidden 4 colors in a specific order
# 12 guesses to guess the colors and order
# No blanks, no duplicates colors
# 6 colors; Green, Blue, Red, Yellow, Orange, Purple

class Mastermind
	extend	ColorArray

	attr_accessor :hidden_code, :win_game, :turn_counter

	def initialize
		@hidden_code = hidden_code_pick
		@win_game = false
		@turn_counter = 0
		@human_picks_secret_code = false
	end

	def who_picks(computer_or_human)
		if computer_or_human[1] == "y"
			self.human_picks_secret_code = true
		end
	end

	def hidden_code_pick(human_picks_secret_code)
		if human_picks_secret_code == false
			self.hidden_code = computer_code_pick
		else
			self.hidden_code = player_number_pick
	end

	def computer_code_pick
		computer_number_array = (1..6).to_a.shuffle.take(4)
		numbers_to_colors(computer_number_array)
	end

	def compare_code(code_guess, hidden_code)
		matches = code_guess & hidden_code
		matched_code = []
		win_check = 0
		i = 0
		4.times do 
			if code_guess[i] == hidden_code[i]
				matched_code << code_guess[i]
				win_check += 1
			else
				matched_code << "x"
			end
			i += 1
		end
		puts "\n\n--------------------------------------------------------------\n\n"
		puts "MATCHED COLORS: #{matches}"
		puts "CODE MATCH: #{matched_code}"
		puts "Guess number #{turn_counter + 1} of 12"
		puts "\n--------------------------------------------------------------\n\n"
		win?(win_check)
	end

	def win?(win_check)
		if win_check == 4
			self.win_game = true
		end
	end
end

class HumanCodePick < Mastermind
	extend ColorArray

	attr_accessor :player_color_array

	def initialize
		@player_color_array
	end

	def player_number_pick
		display_color_choices
		number_array = []
		4.times do
			input = gets.chomp.to_i
			if (1..6).include?(input) && number_array.include?(input) == false
				number_array << input
			else
				puts "please enter one number and 'enter'"
				redo
			end
		end
		player_color_array = numbers_to_colors(player_number_array)
		p "You picked #{player_color_array.join(", ")}"
		return player_color_array
	end

end

module ColorArray

	def display_color_choices
		puts "Type the number (1-6) corresponding to the color and 'enter' (4x)"
		puts "1 - Green" 
		puts "2 - Blue" 
		puts "3 - Red"
		puts "4 - Yellow"
		puts "5 - Orange"
		puts "6 - Purple\n\n"
	end

	def numbers_to_colors(number_array)
		color_array = []
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
end

def start_game
	human_code = HumanCodePick.new
	current_game = Mastermind.new
	puts "Do you want to pick the secret code? (y/n)"
	computer_or_human = gets.chomp.downcase
	who_picks(current_game.computer_or_human)
	assign_guesser
end

def assign_guesser
	if current_game.human_picks_secret_code == true
		code_guess = human_code.player_number_pick # player picks secret code
	 else
	 	code_guess = current_game.computer_code_pick # computer picks secret code
	 end 
	play_game(current_game, code_guess)
end

def play_game(current_game, code_guess)
	12.times do
		puts "hidden code #{current_game.hidden_code}"
		current_game.compare_code(code_guess, current_game.hidden_code)
		puts "press enter to continue"
		pause_game = gets.chomp
		if current_game.win_game == true 
			winner_message
			break
		else
			 current_game.turn_counter += 1
		end
		if current_game.turn_counter == 12 
			loser_message
			break
		else next
		end
	end
	
	puts "\n\t~GAME OVER~\n\n\n\n\n\n\n\n\n"
end

def winner_message
	puts "Congratulations! you matched the hidden code!\n"
end

def loser_message
	puts "Sorry you lost. Better luck next time!"
end

puts "\n\n\n--------------------------------------------------------------"
puts "--------------------------------------------------------------\n\n"
puts "Mastermind! Deduce the 4 color code within 12 guesses to win!\n"
puts "\nPossible colors include: \n"
puts "Green, Blue, Red, Yellow, Orange, Purple"
puts "\n--------------------------------------------------------------"
puts "--------------------------------------------------------------\n\n\n"

start_game


