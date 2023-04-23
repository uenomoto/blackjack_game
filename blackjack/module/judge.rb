# 勝ち負けのルールを決める
module Judge
  # リザルトを表示するメソッド
  def result_score
    player_score = @player.hand.score
    dealer_score = @dealer.score
  
    puts "#{@player.name}の得点は#{player_score}です。"
    puts "#{@dealer.name}の得点は#{dealer_score}です。"

    [player_score, dealer_score]
  end

  # リザルトを判定するメソッド、条件分岐順番大事でなかったら順番を疑う
  def result
    player_score, dealer_score = result_score

    if player_score > 21 && dealer_score > 21
      puts 'どちらもオーバーしました。引き分けです'
    elsif player_score > 21
      puts "#{@player.name}の負けです"
    elsif dealer_score > 21 || player_score > dealer_score
      puts "#{@player.name}の勝ちです！"
    elsif player_score < dealer_score
      puts "#{@player.name}の負けです"
    else
      puts '引き分けです'
    end
  end
end
