# ブラックジャックのプレイヤーを表現するクラスです。手札を持つ
class Player
  attr_reader :hand, :name

  # 初期化時に空の手札を作成する
  def initialize(name:)
    @name = name
    @hand = Hand.new
  end
end
