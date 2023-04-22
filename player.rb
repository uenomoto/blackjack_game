require './hand'

class Player
  attr_reader :hand

  def initialize
    # 初期化時に空の手札を作成する
    @hand = Hand.new
  end
end
