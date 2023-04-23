require './card'

# トランプの山札を表現するクラスです。山札の作成、シャッフル、カードを引く機能がある
class DeckOfCards
  SUITS = %w[ハート ダイヤ クラブ スペード].freeze # 定数は変更は望まないため、凍結で変更不可能（immutable）な配列にしてます
  NUMBERS = (2..10).to_a + %w[A J Q K].freeze # to_aメソッドは今回の場合2~10の配列が入ってる

  # 山札を作成しシャッフルする
  def initialize
    @cards = SUITS.product(NUMBERS).map { |suit, number| Card.new(suit, number) }
    shuffle
  end

  # 山札のカードを引く
  def draw_card
    @cards.pop
  end

  # 山札をシャッフルする
  def shuffle
    @cards.shuffle!
  end
end

# 山札クラスを初期化しインスタンス作成した時にカードクラスからスートとナンバー属性を持ってきて１枚ずつカードを作ってる
# イメージとしてはカードクラスから白紙のトランプを持ってきてスートとナンバーを書く欄がありここの初期化でそれぞれ１枚ずつ書いているイメージ

# リファクダ前
# SUITS.each do |suit|
#   NUMBERS.each do |number|
#     cards << Card.new(suit, number)
#   end
# end
# @cards = cards
# スート定数から文字列の配列を１つずつsuit引数に、ナンバー定数からは2~10の整数とA J Q Kの文字列を1つずつnumber引数に
# インスタンス変数の@cardsに１枚ずつカードを追加全部で52枚のトランプが出来上がり、山札とする。

# リファクダ後(ロボコップが教えてくれました)
# SUITS.product(NUMBERS).map { |suit, number| Card.new(suit, number) }
# productメソッドは複数の配列を組み合わせを生成。(スートとナンバーの組み合わせ(29と30列あたりの部分))
# mapメソッドで新しい配列を作り、あとはeachと一緒で１枚ずつ格納。

# 配列(山札)を一枚だけ抜き取るメソッドないかと探してたらありました。
# popメソッドは配列の一番最後を削除している、よって同時に山札の残枚数も減る実装もできている(裏側のトランプを１枚ドローするイメージ)
# ちなみに削除されたカードは、draw_cardメソッドに返されているので配列からは削除されたが実際には消えていない。

# Rubyはすごいshuffle!メソッドがあります。
# これは配列をランダムにシャッフルしてくれます。