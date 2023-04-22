class Hand
  attr_reader :cards

  def initialize
    # 初期化時に空の手札を作成する
    @cards = []
  end

  def add_card(card)
    # カードを手札に追加する
    @cards << card
  end

  def score
    # 現在の手札の合計得点を計算する
    total = @cards.inject(0) { |sum, card| sum + card_value(card) }
    # エースがある場合、合計が11以下であれば、エースを11として扱う
    @cards.select { |card| card.number == 'A' && total <= 11 }.count.times { total += 10 }
    total
  end

  def to_s
    # 手札のカードを文字列に変換する,変換しないと点数が抜け出せずエラー
    @cards.join(', ')
  end

  private

  def card_value(card)
    # カードの得点を計算する
    case card.number
    when 2..10 then card.number
    when 'J', 'Q', 'K' then 10
    when 'A' then 1
    end
  end
end
