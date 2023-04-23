# 一枚のトランプのカードを表現するクラスです。スートと番号を持ち、メソッドで文字列表現にしている。
class Card
  attr_reader :suit, :number

  def initialize(suit, number)
    @suit = suit
    @number = number
  end

  # to_sメソッドで文字列表現に変換
  def to_s
    "#{suit}の#{number}"
  end
end
