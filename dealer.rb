require './player'

#  ディーラーを表現するクラスで、Player クラスを継承、2枚目のカードを隠す機能を追加。
class Dealer < Player
  # 直接handクラスにアクセスするのを防ぐためディーラークラスでカプセル化
  def firest_card
    @hand.cards[0]
  end
  
  def second_card
    @hand.cards[1]
  end
  
  def score
    @hand.score
  end
  
  def add_card(card)
    @hand.add_card(card)
  end

  def hidden_hand
    # ２枚目のカードを隠した手札を作成する
    hidden_card = Card.new('', '')
    Hand.new.tap do |hand|
      hand.add_card(firest_card)
      hand.add_card(hidden_card)
    end
  end
end

# 複雑なのでここでまとめさせてください
# デメテルの法則について2点ドットはダメだと思っていましたが例外がある。↓ゲームクラスから持ってきたコードですが
# "ディーラーの引いたカードは#{@dealer.hidden_hand.cards[0]}です。"
# これは、**ゲームクラスがディーラークラスとハンドクラス２つのクラスに依存してしまっている。**よってデメテルに反しています。
# ゲームクラスがディーラークラスのメソッドとハンドクラスのメソッド２クラスの内部構成にお邪魔しているのがNG
# 改善策は、ディーラークラスでメソッドを作り、カプセル化しゲームクラスに渡す
# 修正後が、"ディーラーの引いたカードは#{@dealer.first_card}です。"
# これにより、ゲームクラスがハンドクラスのcardsメソッドに直接アクセスせずにディーラークラス経由で１枚目のカードを参照できます

# 2個目のコードの場合、"あなたの現在の得点は#{@player.hand.score}です。カードを引きますか？（Y/N）"
# これも2点ドットじゃん！！(結論はこのままが正解)
# プレイヤーはハンドと直接関連しており、scoreメソッドはハンドクラスのメソッドの為
# 結局は,ゲームクラスから内部構成に入ってるのはハンドクラスのscoreメソッドだけだから大丈夫

# 結論、デメテルの法則は各オブジェクトが他のオブジェクトの**内部構造**に直接アクセスしないようにすること
