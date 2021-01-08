# frozen_string_literal: true

# Player class
class Player
  def initialize(name = 'Player 1')
    @name = name
  end

  attr_reader :name

  # generic input validation
  def get_input(question_to_display, valid_characters = %w[Y N], _feedback = nil)
    input = false
    loop do
      print question_to_display
      input = gets.chomp.upcase
      break if valid_characters.include?(input)

      puts 'Invalid input.'
    end
    input
  end

  # display generic win.los message based on boolean parameter
  def win_or_lose(game_result)
    puts game_result ? 'YOU WIN!' : 'YOU LOSE.'
  end

  # the player doesnt have anything to reset for this game so it is empty
  def reset; end
end
