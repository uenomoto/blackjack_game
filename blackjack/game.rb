require './blackjack/module/judge'

# ブラックジャックのゲーム全体を制御するクラスです。プレイヤーとディーラーのターン、結果の表示などを管理
class Game
  include Judge
  # 山札、プレイヤー、ディーラーの初期化
  def initialize
    @deck = DeckOfCards.new
    @player = Player.new
    @dealer = Dealer.new
  end

  # ゲーム開始時、プレイヤーとディーラーが2枚ずつカードを引く,playで開始
  def start
    2.times do
      @player.hand.add_card(@deck.draw_card)
      @dealer.hand.add_card(@deck.draw_card)
    end
    play
  end

  private

  # ここから他のクラスでは使わないかつ変更したらアプリが破壊するメソッド達なのでプライベートメソッドです。
  def play
    puts 'ブラックジャックを開始します。'
    show_initial_cards
    player_turn
    dealer_turn
    result
    puts 'ブラックジャックを終了します。'
  end

  # 初期カードを表示する
  def show_initial_cards
    @player.hand.cards.each do |card|
      puts "あなたの引いたカードは#{card}です。"
    end
    puts "ディーラーの引いたカードは#{@dealer.firest_card}です。"
    puts 'ディーラーの引いた2枚目のカードはわかりません。'
  end

  # プレイヤーのターンを処理する
  def player_turn
    while @player.hand.score < 21
      puts "あなたの現在の得点は#{@player.hand.score}です。カードを引きますか？（Y/N）"
      input = player_input
      break if input == 'N'

      draw_card_add_card_player_hand
    end
  end

  # プレイヤーにカードを引くか引かないか選択してもらうメソッド
  def player_input
    input = ''
    loop do
      input = gets.chomp.upcase
      break if %w[Y N].include?(input)

      puts 'YかNでお願いします'
    end
    input # 選択結果を返す
  end

  # 読んで字の如く、ドローしたらプレイヤーの手札に追加するコードが書いてあるメソッド
  def draw_card_add_card_player_hand
    draw_card = @deck.draw_card
    @player.hand.add_card(draw_card)
    puts "あなたの引いたカードは#{draw_card}です。"
  end

  # ディーラーのターンを処理する
  def dealer_turn
    puts "ディーラーの引いた2枚目のカードは#{@dealer.second_card}でした。"
    puts "ディーラーの現在の得点は#{@dealer.score}です"
    while @dealer.hand.score < 17
      draw_card = @deck.draw_card
      @dealer.add_card(draw_card)
      puts "ディーラーの引いたカードは#{draw_card}です。"
    end
  end
end
