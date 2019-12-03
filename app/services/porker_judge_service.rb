module PorkerJudgeService


class JudgeHands 

attr_accessor :hand_array, :cards, :hands, :error_message, :result, :error_messages

  def initialize(card)
    @cards = card
  end

  def execute
#   エラーメッセージを貯めていく配列を定義
    @error_messages = []
#   入力されたものを配列に
    @hand_array = @cards.split.sort_by {|k| k[/\d+/].to_i}
  
#   配列の要素数が５個じゃない場合をはじく
      if (@hand_array.size.to_i != 5)
          @error_message1 = "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせで５枚のカードを指定してください。(例)S1 H3 D9 C13 S11"
          @error_messages.push(@error_message1)
      else
  
#   配列の要素を取り出して名前をつける
  self.class.const_set(:A1,@hand_array[0].slice(0).to_s)
  self.class.const_set(:N1,@hand_array[0].gsub(/[^\d]/, "").to_i) 
  self.class.const_set(:A2,@hand_array[1].slice(0).to_s)
  self.class.const_set(:N2,@hand_array[1].gsub(/[^\d]/, "").to_i) 
  self.class.const_set(:A3,@hand_array[2].slice(0).to_s) 
  self.class.const_set(:N3,@hand_array[2].gsub(/[^\d]/, "").to_i) 
  self.class.const_set(:A4,@hand_array[3].slice(0).to_s) 
  self.class.const_set(:N4,@hand_array[3].gsub(/[^\d]/, "").to_i) 
  self.class.const_set(:A5,@hand_array[4].slice(0).to_s) 
  self.class.const_set(:N5,@hand_array[4].gsub(/[^\d]/, "").to_i) 
  
  
#   取り出したものを再度並べてみる:もともとのものと比較するため
  hand_check = ["#{A1}"+"#{N1}","#{A2}"+"#{N2}","#{A3}"+"#{N3}","#{A4}"+"#{N4}","#{A5}"+"#{N5}"] 
  
#   入力されたものと並べ直したものを比較して違う箇所を抜き出す
          @hand_array.zip(hand_check).each_with_index do |(x,y),i| 
            if (x!=y) 
                @error_message2 = "#{i+1}番目のカード指定文字が不正です。(#{@hand_array[i]})" 
                 @error_messages.push(@error_message2)
            end
          end
#   それぞれのカードの中に不適切なものがないか確認
          if ((A1 !="S" && A1 !="D" && A1 !="H" && A1 !="C") || (N1>13) || (N1<1))
            @error_message3 = "1番目のカード指定文字が不正です。(#{@hand_array[0]})"
             @error_messages.push(@error_message3)
          end
          if ((A2 !="S" && A2 !="D" && A2 !="H" && A2 !="C") || (N2>13) || (N2<1))
            @error_message4 = "2番目のカード指定文字が不正です。(#{@hand_array[1]})"
             @error_messages.push(@error_message4)
          end
          if ((A3 !="S" && A3 !="D" && A3 !="H" && A3 !="C") || (N3>13) || (N3<1))
            @error_message5 = "3番目のカード指定文字が不正です。(#{@hand_array[2]})"
             @error_messages.push(@error_message5)
          end
          if ((A4 !="S" && A4 !="D" && A4 !="H" && A4 !="C") || (N4>13) || (N4<1))
            @error_message6 = "4番目のカード指定文字が不正です。(#{@hand_array[3]})"
             @error_messages.push(@error_message6)
          end
          if ((A5 !="S" && A5 !="D" && A5 !="H" && A5 !="C") || (N5>13) || (N5<1))
          #unless (/\b[CDSH]\b/ === A5 || /[1-9]|1[0-3]/ === N5)
            @error_message7 = "5番目のカード指定文字が不正です。(#{@hand_array[4]})"
             @error_messages.push(@error_message7)
          end
      
#   重複がないか
          if (("#{A1}"+"#{N1}" == "#{A2}"+"#{N2}") || ("#{A2}"+"#{N2}" == "#{A3}"+"#{N3}") || ("#{A3}"+"#{N3}" == "#{A4}"+"#{N4}") || ("#{A4}"+"#{N4}" == "#{A5}"+"#{N5}")) &&
             @error_message1.blank? &&
             @error_message2.blank? &&
             @error_message3.blank? &&
             @error_message4.blank? &&
             @error_message5.blank? &&
             @error_message6.blank? &&
             @error_message7.blank? 
             
            @error_message8 = "カードがしています"
             @error_messages.push(@error_message8)
          end
      
#   エラーここまで
      
#   ストレートフラッシュの判定
          if (((A1==A2) && (A2==A3) && (A3==A4) && (A4==A5)) &&
             (((N1==N2-1) && (N1==N3-2) && (N1==N4-3) && (N1==N5-4)) ||
             ((N1==1) && (N2==10) && (N3==11) && (N4==12) && (N5==13)) ||
             ((N1==1) && (N2==2) && (N3==11) && (N4==12) && (N5==13)) ||
             ((N1==1) && (N2==2) && (N3==3) && (N4==12) && (N5==13)) ||
             ((N1==1) && (N2==2) && (N3==3) && (N4==4) && (N5==13)))) 
            @result = "ストレートフラッシュ"
          
#   フォーカードの判定
          elsif (((N1==N2) && (N2==N3) && (N3==N4)) || ((N2==N3) && (N3==N4) && (N4==N5)))
            @result = "フォーカード"
                        
#   フルハウスの判定
          elsif (((N1==N2) && (N2==N3) && (N4==N5)) || ((N1==N2 && N3==N4 && N4==N5)))
            @result = "フルハウス"
                        
#   フラッシュの判定
          elsif ((A1==A2) && (A2==A3) && (A3==A4) && (A4==A5))
            @result = "フラッシュ"
                        
#   ストレートの判定
          elsif ((N2==N1+1) && (N3==N1+2) && (N4==N1+3) && (N5==N1+4)) || ((N1==1) && (N2==10) && (N3==11) && (N4==12) && (N5==13)) ||
                ((N1==1) && (N2==2) && (N3==11) && (N4==12) && (N5==13)) || ((N1==1) && (N2==2) && (N3==3) && (N4==12) && (N5==13)) ||
                ((N1==1) && (N2==2) && (N3==3) && (N4==4) && (N5==13)) 
            @result = "ストレート"
                            
#   スリーカードの判定
          elsif (((N1==N2) && (N2==N3)) || ((N2==N3) && (N3==N4)) || ((N3==N4) && (N4==N5)))
            @result = "スリーカード"
                            
#   ツーペアの判定
          elsif (((N1==N2) && (N3==N4)) || ((N1==N2) && (N4==N5)) || ((N2==N3) && (N4==N5)))
            @result = "ツーペア"
                            
#   ワンペアの判定
          elsif ((N1==N2) || (N2==N3) || (N3==N4) || (N4==N5))
            @result = "ワンペア"
#   その他                            
          else
            @result = "ハイカード" 
            
          end
      end
    

    end
    
end
  
end
