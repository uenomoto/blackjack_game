require './blackjack/card'
require './blackjack/deck_of_cards'
require './blackjack/hand'
require './blackjack/player'
require './blackjack/dealer'
require './blackjack/game'

# ゲームを起動する際はこちらから！！

# ゲームの開始
game = Game.new
game.start
