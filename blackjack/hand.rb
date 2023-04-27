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
    # 手札にAがある場合、合計点数が11以下であれば、Aを11点として扱う、Aは元々1点なので追加は10点になっている
    @cards.select { |card| card.number == 'A' && total <= 11 }.count.times { total += 10 }
    total
  end

  # 手札のカードを文字列に変換する、もし文字列にしないとオブジェクトIDになる,joinメソッドは指定した文字列をくり抜くイメージ
  def cards_to_s
    @cards.join(', ')
  end

  private

  # カードの得点を決めている、このクラスでしか使ってないかつ、依存も変更もしてほしくないためプラベ
  def card_value(card)
    case card.number
    when 2..10 then card.number
    when 'J', 'Q', 'K' then 10
    when 'A' then 1
    end
  end
end

# injectメソッドについて
# これ結果を蓄積するのにめちゃ便利でしてクエストの総和sum_1_100問題と同じことができます
# 引数に初期値を入れsumに得点、card_value(card)のcard引数でナンバーが何が入ってるか特定し得点を特定して加算していってる
# イメージとしては、最初のカードが2として2枚目がAとします。(ここではスートは関係ないので省略)
# 0 + 2 = 2 → 2 + 11 = 13こんな感じです。Aは合計が11点未満なので11点になります。
# 1枚目K、2枚目9、3枚目はAとしたら
# 0 + 10 = 10 → 10 + 9 = 19 → 19 + 1 = 20となる

# selectメソッドは配列の中身全部確認し決めた条件のみを出すことができる