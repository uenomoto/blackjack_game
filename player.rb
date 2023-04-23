require './hand'

# ブラックジャックのプレイヤーを表現するクラスです。手札を持つ
class Player
  attr_reader :hand

  # 初期化時に空の手札を作成する
  def initialize
    @hand = Hand.new
  end
end
