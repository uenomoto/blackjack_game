require './card'

# トランプの山札を表現するクラスです。山札の作成、シャッフル、カードを引く機能がある
class DeckOfCards
  SUITS = %w[ハート ダイヤ クラブ スペード].freeze # 定数は変更は望まないため、凍結で変更不可能（immutable）な配列にしてます
  NUMBERS = (2..10).to_a + %w[A J Q K]

  def initialize
    # 山札を作成しシャッフルする
    @cards = SUITS.product(NUMBERS).map { |suit, number| Card.new(suit, number) }
    shuffle
  end

  # 山札の一番上のカードを引く
  def draw_card
    @cards.pop
  end

  # 山札をシャッフルする
  def shuffle
    @cards.shuffle!
  end
end
