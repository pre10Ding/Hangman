# frozen_string_literal: true

# main code for hangman
require './lib/player'
require './lib/hangman_logic'
require 'yaml'

GUESS_LIMIT = 6

# game setup
player = Player.new
# check if user wants to load save file
hangman = HangmanLogic.load_game?(player)? HangmanLogic.load_game : HangmanLogic.new(GUESS_LIMIT)
# start gameplay loop
player.win_or_lose(hangman.play_game(player))
