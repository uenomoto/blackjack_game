# 一枚のトランプのカードを表現するクラスです。スートと番号を持ち、メソッドで文字列表現にしている。
class Card
  SUITS = %w[ハート ダイヤ クラブ スペード].freeze # 定数は変更は望まないため、凍結で変更不可能（immutable）な配列にしてます
  NUMBERS = (2..10).to_a + %w[A J Q K].freeze # to_aメソッドは今回の場合2~10の配列が入ってる
  
  attr_reader :suit, :number

  def initialize(suit, number)
    @suit = suit
    @number = number
  end

  # to_sメソッドで文字列表現に変換
  def to_s
    "#{suit}の#{number}点"
  end
end
