require './blackjack/module/judge'

# ブラックジャックのゲーム全体を制御するクラスです。プレイヤーとディーラーのターン、結果の表示などを管理
class Game
  include Judge
  # 山札、プレイヤー、ディーラーの初期化
  def initialize
    @deck = DeckOfCards.new
    player_name = input_name # 初期化するたびにinput_nameメソッドが呼ばれる。
    @player = Player.new(name: player_name)
    @dealer = Dealer.new(name: 'デーラー')
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
      puts "#{@player.name}の引いたカードは#{card}です。"
    end
    puts "#{@dealer.name}の引いたカードは#{@dealer.firest_card}です。"
    puts "#{@dealer.name}の引いた2枚目のカードはわかりません。"
  end

  # プレイヤーのターンを処理する
  def player_turn
    while @player.hand.score < 21
      puts "#{@player.name}の現在の得点は#{@player.hand.score}です。カードを引きますか？（Y/N）"
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
    puts "#{@player.name}の引いたカードは#{draw_card}です。"
  end

  # ディーラーのターンを処理する
  def dealer_turn
    puts "#{@dealer.name}の引いた2枚目のカードは#{@dealer.second_card}でした。"
    puts "#{@dealer.name}の現在の得点は#{@dealer.score}です"
    while @dealer.score < 17
      draw_card = @deck.draw_card
      @dealer.add_card(draw_card)
      puts "#{@dealer.name}の引いたカードは#{draw_card}です。"
    end
  end

  # 好きな名前を入力できる様にする
  def input_name
    print 'お名前を入力してください: '
    gets.chomp.to_s
  end
end
