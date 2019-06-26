
# Master Mind Game

# Hidden 4 colors in a specific order
# 12 guesses to guess the colors and order
# No blanks, no duplicates colors
# 6 colors; Green, Blue, Red, Yellow, Orange, Purple

class Mastermind
	attr_accessor :hidden_code, :game_is_over, :turn_counter, :human_picks_secret_code, :computer_matched_colors, :computer_matched_secret_code, :possible_colors

	def initialize
		@hidden_code = []
		@game_is_over = false
		@turn_counter = 0
		@human_picks_secret_code = false
		@matched_colors = []
		@matched_secret_code = ["x", "x", "x", "x"]
		@possible_colors = ["green", "blue", "red", "yellow", "orange", "purple"]
	end

	def player_number_pick
		display_color_choices
		number_array = []
		counter = 0
		4.times do
			counter += 1
			print "Spot #{counter}: "
			input = gets.chomp.to_i
			if (1..6).include?(input) && number_array.include?(input) == false
				number_array << input
			else
				puts "please enter one number and 'enter'"
				redo
			end
		end
		player_color_array = numbers_to_colors(number_array)
		p "You picked #{player_color_array.join(", ")}"
		return player_color_array
	end

	def hidden_code_pick
		puts human_picks_secret_code
		if human_picks_secret_code == false
			self.hidden_code = computer_pick_secret_code
		else
			self.hidden_code = player_number_pick
		end
	end

	def computer_code_guess
		computer_guess = []
		unmatched_color_pool = (possible_colors - matched_colors)
		matched_color_pool = (matched_colors - matched_secret_code)
		j = 0
		until j == 4			
			if matched_secret_code[j] == "x" 
				if matched_color_pool.size > 0
					color_to_add = matched_color_pool.sample
					matched_color_pool = (matched_color_pool - color_to_add)
					computer_guess << color_to_add
				else 
					color_to_add = unmatched_color_pool.sample
					unmatched_color_pool = (unmatched_color_pool - color_to_add) 
					computer_guess << color_to_add
				end
			else
				computer_guess << matched_secret_code[j]
			end
			postion += 1
		end
		return computer_guess
	end

	def computer_pick_secret_code
		computer_matched_secret_code << matched_color
		computer_number_array = (1..6).to_a.shuffle.take(4)
		numbers_to_colors(computer_number_array)
	end

	def compare_code(code_guess, hidden_code)
		self.matched_colors = code_guess & hidden_code
		match_all_four = 0
		i = 0
		4.times do 
			if code_guess[i] == hidden_code[i]
				self.matched_secret_code[i] = code_guess[i]
				match_all_four += 1
			else
				self.matched_secret_code[i] = "x"
			end
			i += 1
		end
		puts "\n\n--------------------------------------------------------------\n\n"
		puts "MATCHED COLORS: #{matched_colors}"
		puts "CODE MATCH: #{matched_secret_code}"
		puts "Guess number #{turn_counter + 1} of 12"
		puts "\n--------------------------------------------------------------\n\n"
		game_over?(match_all_four)
	end

	def game_over?(match_all_four)
		if match_all_four == 4
			self.game_is_over = true
		end
	end

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
	current_game = Mastermind.new
	who_picks(current_game)
	play_game(current_game)
end

def guess_picks(current_game)
	if current_game.human_picks_secret_code == true
		return current_game.player_number_pick 
	 else
	 	return current_game.computer_code_guess 
	 end 
end

def who_picks(current_game)
	puts "\nDo you want to pick the secret code? (y/n)\n"
	computer_or_human = gets.chomp.downcase
	if computer_or_human[0] == "y"
		current_game.human_picks_secret_code = true
	elsif computer_or_human == "n"
		return
	else
		who_picks_error(current_game)
	end
	current_game.hidden_code_pick
end

def who_picks_error(current_game)
	puts"\n\n\n--------------------------------------------------------------"
	puts "--------------------------------------------------------------\n\n"
	puts "Please enter a 'y' or 'n'\n\n"
	who_picks(current_game)
end


def play_game(current_game)
	12.times do
		code_guess = guess_picks(current_game)
		puts "hidden code #{current_game.hidden_code}"
		current_game.compare_code(code_guess, current_game.hidden_code)
		puts "press enter to continue"
		pause_game = gets.chomp
		if current_game.game_is_over == true 
			code_has_been_matched(current_game)
			break
		else
			 current_game.turn_counter += 1
		end
		if current_game.turn_counter == 12 
			turn_counter_maxed(current_game)
			break
		else next
		end
	end
	
	puts "\n\t~GAME OVER~\n\n\n\n\n\n\n\n\n"
end

def code_has_been_matched(current_game)
	if current_game.human_picks_secret_code = false
		puts "You lose! The computer guessed your code"
	else
		puts "Congratulations! you won!\n"
	end
end

def turn_counter_maxed(current_game)
	if current_game.human_picks_secret_code = true
		puts "congratulations! The computer didn't guess your code!"
	else
		puts "Sorry you lost. Better luck next time!"
	end
end

puts "\n\n\n--------------------------------------------------------------"
puts "--------------------------------------------------------------\n\n"
puts "Mastermind! Deduce the 4 color code within 12 guesses to win!\n"
puts "\nPossible colors include: \n"
puts "Green, Blue, Red, Yellow, Orange, Purple"
puts "\n--------------------------------------------------------------"
puts "--------------------------------------------------------------\n\n\n"

start_game


