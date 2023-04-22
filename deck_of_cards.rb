require './card'

class DeckOfCards
  SUITS = ['ハート', 'ダイヤ', 'クラブ', 'スペード']
  NUMBERS = ['A'] + (2..10).to_a + ['J', 'Q', 'K']

  def initialize
    # 山札を作成しシャッフルする
    @cards = SUITS.product(NUMBERS).map { |suit, number| Card.new(suit, number) }
    shuffle
  end

  def draw_card
    # 山札の一番上のカードを引く
    @cards.pop
  end

  def shuffle
    # 山札をシャッフルする
    @cards.shuffle!
  end
end
