require './deck_of_cards'
require './player'
require './dealer'

class Game
  def initialize
    # 山札、プレイヤー、ディーラーの初期化
    @deck = DeckOfCards.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    # ゲーム開始時、プレイヤーとディーラーが2枚ずつカードを引く
    2.times do
      @player.hand.add_card(@deck.draw_card)
      @dealer.hand.add_card(@deck.draw_card)
    end
    play
  end

  private

  def play
    puts 'ブラックジャックを開始します。'
    show_initial_cards
    player_turn
    dealer_turn
    result
    puts 'ブラックジャックを終了します。'
  end

  def show_initial_cards
    # 初期カードを表示する
    @player.hand.cards.each do |card|
      puts "あなたの引いたカードは#{card}です。"
    end
    puts "ディーラーの引いたカードは#{@dealer.hidden_hand.cards[0]}です。"
    puts 'ディーラーの引いた2枚目のカードはわかりません。'
  end

  def player_turn
    # プレイヤーのターンを処理する
    while @player.hand.score < 21
      puts "あなたの現在の得点は#{@player.hand.score}です。カードを引きますか？（Y/N）"
      input = ''
      loop do
        input = gets.chomp.upcase
        break if ['Y', 'N'].include?(input)

        puts "YかNでお願いします"
      end

      break if input == 'N'

      draw_card = @deck.draw_card
      @player.hand.add_card(draw_card)
      puts "あなたの引いたカードは#{draw_card}です。"
    end
  end

  def dealer_turn
    # ディーラーのターンを処理する
    puts "ディーラーの引いた2枚目のカードは#{@dealer.hand.cards[1]}でした。"
    puts "ディーラーの現在の得点は#{@dealer.hand.score}です"
    while @dealer.hand.score < 17
      draw_card = @deck.draw_card
      @dealer.hand.add_card(draw_card)
      puts "ディーラーの引いたカードは#{draw_card}です。"
    end
  end

  # 条件分岐順番大事でなかったら順番を疑う
  def result
    # 結果を表示する
    player_score = @player.hand.score
    dealer_score = @dealer.hand.score
  
    puts "あなたの得点は#{player_score}です。"
    puts "ディーラーの得点は#{dealer_score}です。"
  
    if player_score > 21 && dealer_score > 21
      puts 'どちらもオーバーしました。引き分けです'
    elsif player_score > 21
      puts 'あなたの負けです'
    elsif dealer_score > 21 || player_score > dealer_score
      puts 'あなたの勝ちです！'
    elsif player_score < dealer_score
      puts 'あなたの負けです'
    else
      puts '引き分けです'
    end
  end
end
