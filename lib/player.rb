# frozen_string_literal: true

# Player class
class Player
  def initialize(name = 'Player 1')
    @name = name
  end

  attr_reader :name

  def get_input(question_to_display, valid_characters = %w[Y N], length = 1, _feedback = nil)
    input = false
    loop do
      puts question_to_display
      input = gets.chomp.upcase
      # subtracting sets leaves an empty if all eles in the first set exist in 2nd
      break if input.length == length && (input.chars - valid_characters).empty?

      puts 'Invalid input.'
    end
    input
  end

  def win(turns_elapsed)
    puts "Congradulations! You won on turn #{turns_elapsed}!"
  end

  def lose(code)
    puts "Game Over!\nThe code was #{code}."
  end

  # the player doesnt have anything to reset for this game so it is empty
  def reset; end
end
