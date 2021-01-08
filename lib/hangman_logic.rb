# frozen_string_literal: true

require 'yaml'

# hangman class
class HangmanLogic
  def initialize(guess_limit)
    @guess_limit = guess_limit
    @question_to_display = 'Please enter a letter or "SAVE" to save your game: '
    @valid_characters = ('A'..'Z').to_a + ['SAVE']
    @secret_word = choose_word
    @correct_letters = ('_' * @secret_word.length).chars
    @incorrect_letters = []
  end

  # game loop
  def play_game(player)
    puts "\nHere is the secret word:"
    display_game_state
    loop do
      input = player.get_input(@question_to_display, @valid_characters)

      save_and_exit if input == 'SAVE'
      @incorrect_letters << input unless check_and_process_input(input) || @incorrect_letters.include?(input)
      display_game_state

      # check if the player lose (false), won (true), or if the game is still ongoing (nil)
      game_end = end_game?
      return game_end if game_end || game_end == false
    end
  end

  # ask user if they want to use save file, then check if the save file exists.
  def self.load_game?(player)
    puts 'Welcome to Hangman!'
    load = player.get_input('Would you like to load your save file? (Y/N) ', %w[Y N])
    if load == 'Y'
      # check if file exists
      return true if File.file?('save_file.yaml')

      print 'No save file detected. '
    end
    puts 'Starting a new game.'
    false
  end

  # Class method that returns a instance of it created from save file.
  def self.load_game
    puts 'Save file loaded successfully.'
    YAML.load(open('save_file.yaml', 'r').read)
  end

  private

  # processes the letters that user inputs, and add the correct ones to the appropriate variables
  def check_and_process_input(input)
    correct_guess = false # a flag to be returned

    # check the input against each letter of the secret word and add those to the displayed word.
    @secret_word.chars.select.with_index do |char, index|
      if char.upcase == input
        correct_guess = true
        @correct_letters[index] = input
      end
    end

    correct_guess
  end

  # get random word from word list file
  def choose_word
    open('word_list.txt') do |file|
      file_content = file.readlines
      file_content[rand(file_content.size)].strip
    end
  end

  def save_and_exit
    puts YAML.dump(self)
    open('save_file.yaml', 'w') { |file| file.write(YAML.dump(self)) }
    puts 'Your game has been saved. To resume your game, use the load option during start up.'
    puts 'Goodbye!'
    exit
  end

  # check to see if the game should end, and how it should end
  def end_game?
    # break condi #1, if length of incorrect letters goes over GUESS LIMIT
    if @incorrect_letters.length >= GUESS_LIMIT
      puts "You have no more guesses! The word was \"#{@secret_word.upcase}\""
      return false
    end
    # break condi #1, if there are no more '_' characters left in correct letters
    return true if @correct_letters.none?('_')

    # if game is still ongoing, return nil
    nil
  end

  # show the display word and the incorrect letters guessed so far
  def display_game_state
    puts @correct_letters.join('')
    puts "Incorrect guesses: #{@incorrect_letters.join}"
  end
end
