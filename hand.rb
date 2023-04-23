# プレイヤーとディーラーの手札を表現するクラスです。カードを追加し、手札の得点を計算する機能がある
class Hand
  attr_reader :cards

  # 初期化時に空の手札を作成する
  def initialize
    @cards = []
  end

  # カードを手札に追加する
  def add_card(card)
    @cards << card
  end

  # 現在の手札の合計得点を計算する
  def score
    total = @cards.inject(0) { |sum, card| sum + card_value(card) }
    # エースがある場合、合計が11以下であれば、エースを11として扱う
    @cards.select { |card| card.number == 'A' && total <= 11 }.count.times { total += 10 }
    total
  end

  # 手札のカードを文字列に変換する,変換しないと点数が抜け出せずエラー
  def to_s
    @cards.join(', ')
  end

  private

  # カードの得点を計算する
  def card_value(card)
    case card.number
    when 2..10 then card.number
    when 'J', 'Q', 'K' then 10
    when 'A' then 1
    end
  end
end
