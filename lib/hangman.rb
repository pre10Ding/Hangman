GUESS_LIMIT = 6
require 'player'

def choose_word
  chosen_word = ''
  open('word_list.txt') do |file|
    file_content = file.readlines
    chosen_word = file_content[rand(file_content.size)].strip
  end
end

# game setup
p secret_word = choose_word
correct_letters = ('_' * secret_word.length).chars
incorrect_letters = []
game_result = false
puts 'Welcome to Hangman!'
puts correct_letters.join('')

# loop
loop do
  print 'Please enter a letter or "SAVE" to save your game: '
  input = gets.chomp.downcase
  # need input validation here

  correct_guess = false

  secret_word.chars.select.with_index do |char, index|
    if char.downcase == input
      correct_guess = true
      correct_letters[index] = input
    end
  end

  incorrect_letters << input unless correct_guess

  puts correct_letters.join('')
  puts "Incorrect guesses: #{incorrect_letters.join}"

  # break condi #1, if length of incorrect letters goes over GUESS LIMIT
  break if incorrect_letters.length >= GUESS_LIMIT

  # break condi #1, if there are no more '_' characters left in correct letters
  if correct_letters.none?('_')
    game_result = true
    break
  end
end

puts game_result ? 'YOU WIN!' : 'YOU LOSE.'
