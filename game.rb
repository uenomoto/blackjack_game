require './deck_of_cards'
require './player'
require './dealer'

# ブラックジャックのゲーム全体を制御するクラスです。プレイヤーとディーラーのターン、結果の表示などを管理
class Game
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

  # リザルトを表示するメソッド
  def result_score
    player_score = @player.hand.score
    dealer_score = @dealer.hand.score
  
    puts "あなたの得点は#{player_score}です。"
    puts "ディーラーの得点は#{dealer_score}です。"

    [player_score, dealer_score]
  end

  # リザルトを判定するメソッド、条件分岐順番大事でなかったら順番を疑う
  def result
    player_score, dealer_score = result_score

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
