class Card
  attr_reader :suit, :number

  def initialize(suit, number)
    @suit = suit
    @number = number
  end

  def to_s
    "#{suit}の#{number}"
  end
end
