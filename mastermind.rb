
# Master Mind Game

# Hidden 4 colors in a specific order
# 12 guesses to guess the colors and order
# No blanks, no duplicates colors
# 6 colors; Green, Blue, Red, Yellow, Orange, Purple

# Computer randomly chooses four colors
class Mastermind
	attr_accessor :hidden_code

	def initialize
		@hidden_code = []
	end

	def computer_hidden_code
		number_array = (1..6).to_a.shuffle.take(4)
		populate_hidden_code(number_array)
	end

	def populate_hidden_code(number_array)
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

			self.hidden_code << color
		end
	end
end

puts "Mastermind! Deduce the four color code in 12 guesses."
#puts "Who picks to hidden code? 1 for human; 2 for computer"
#who_pics = gets.chomp.downcase

puts "Possible colors include: "
puts "Green, Blue, Red, Yellow, Orange, Purple"

player_guess = []
turn_counter = 0
win_game? = false

def start_game
	current_game = Mastermind.new

end

def play_game
	until turn_counter == 12 || win_game == true
		
		player_number_ pick 
end

def player_number_pick
	puts "Pick your colors: "
	puts
end

def display_color_choices
	puts "Type the number corresponding to the color separated by a comma"
	puts "1 Green" 
	puts "2 Blue" 
	puts "3 Red"
	puts "4 Yellow"
	puts "5 Orange"
	puts "6 Purple"
end



