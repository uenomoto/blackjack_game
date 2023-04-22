require './player'

class Dealer < Player
  def hidden_hand
    # ２枚目のカードを隠した手札を作成する
    hidden_card = Card.new('ディーラーの引いた2枚目', 'カードはわかりません。')
    Hand.new.tap do |hand|
      hand.add_card(@hand.cards[0])
      hand.add_card(hidden_card)
    end
  end
end
