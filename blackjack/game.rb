require './blackjack/module/judge'

# ブラックジャックのゲーム全体を制御するクラスです。プレイヤーとディーラーのターン、結果の表示などを管理
class Game
  include Judge
  # 山札、プレイヤー、ディーラーの初期化
  def initialize
    @deckofcards = DeckOfCards.new
    player_name = input_name # 初期化するたびにinput_nameメソッドが呼ばれる。
    @player = Player.new(name: player_name)
    @dealer = Dealer.new
  end

  def start
    puts 'ブラックジャックを開始します。'
    draw_two_cards
    show_initial_cards
    player_turn
    dealer_turn
    result
    puts 'ブラックジャックを終了します。'
  end

  private

  # ここから他のクラスでは使わないかつ変更したらアプリが破壊するメソッド達なのでプライベートメソッドです。
  def draw_two_cards
    2.times do
      @player.hand.add_card(@deckofcards.draw_card)
      @dealer.add_card(@deckofcards.draw_card)
    end
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

      draw_card
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

  # ドローしたらプレイヤーの手札に追加するメソッド
  def draw_card
    draw_card = @deckofcards.draw_card
    @player.hand.add_card(draw_card)
    puts "#{@player.name}の引いたカードは#{draw_card}です。"
  end

  # ディーラーのターンを処理する
  def dealer_turn
    puts "#{@dealer.name}の引いた2枚目のカードは#{@dealer.second_card}でした。"
    puts "#{@dealer.name}の現在の得点は#{@dealer.score}です"
    while @dealer.score < 17
      draw_card = @deckofcards.draw_card
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
