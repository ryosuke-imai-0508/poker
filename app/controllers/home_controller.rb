class HomeController < ApplicationController
  def top
  end
  
  
  def judge
  
  #入力されたものを配列に
  @hand = params[:hand].split.sort_by {|k| k[/\d+/].to_i}
  
      #条件ここから    
      if ( (@hand.size.to_i == 5) && 
           
      #配列の要素を取り出して名前をつける
        ( self.class.const_set(:A1,@hand[0].slice(0))
          self.class.const_set(:N1,@hand[0].gsub(/[^\d]/, "").to_i) 
          self.class.const_set(:A2,@hand[1].slice(0))
          self.class.const_set(:N2,@hand[1].gsub(/[^\d]/, "").to_i) 
          self.class.const_set(:A3,@hand[2].slice(0)) 
          self.class.const_set(:N3,@hand[2].gsub(/[^\d]/, "").to_i) 
          self.class.const_set(:A4,@hand[3].slice(0)) 
          self.class.const_set(:N4,@hand[3].gsub(/[^\d]/, "").to_i) 
          self.class.const_set(:A5,@hand[4].slice(0)) 
          self.class.const_set(:N5,@hand[4].gsub(/[^\d]/, "").to_i) 
          
          hand_check = ["#{A1}"+"#{N1}","#{A2}"+"#{N2}","#{A3}"+"#{N3}","#{A4}"+"#{N4}","#{A5}"+"#{N5}"] 
        )      
        
      (hand_check == @hand) &&
      
       ("#{A1}"+"#{N1}" != "#{A2}"+"#{N2}") &&
       ("#{A2}"+"#{N2}" != "#{A3}"+"#{N3}") &&
       ("#{A3}"+"#{N3}" != "#{A4}"+"#{N4}") &&
       ("#{A4}"+"#{N4}" != "#{A5}"+"#{N5}") &&
     
      ((A1=="S") || (A1=="D") || (A1=="H") || (A1=="C")) &&
      ((A2=="S") || (A2=="D") || (A2=="H") || (A2=="C")) &&
      ((A3=="S") || (A3=="D") || (A3=="H") || (A3=="C")) &&
      ((A4=="S") || (A4=="D") || (A4=="H") || (A4=="C")) &&
      ((A5=="S") || (A5=="D") || (A5=="H") || (A5=="C")) &&
      
      (1..13)===N1 && (1..13)===N2 && (1..13)===N3 && (1..13)===N4 && (1..13)===N5
      
        ) 
      #条件ここまで
      
            #ストレートフラッシュの判定
            if ((A1==A2) && (A2==A3) && (A3==A4) && (A4==A5)) &&
               (((N1==N2-1) && (N1==N3-2) && (N1==N4-3) && (N1==N5-4)) ||
               ((N1==1) && (N2==10) && (N3==11) && (N4==12) && (N5==13)) ||
               ((N1==1) && (N2==2) && (N3==11) && (N4==12) && (N5==13)) ||
               ((N1==1) && (N2==2) && (N3==3) && (N4==12) && (N5==13)) ||
               ((N1==1) && (N2==2) && (N3==3) && (N4==4) && (N5==13))) 
                flash[:notice] = "ストレートフラッシュ"
                render("home/top")
                
            #フォーカードの判定
            elsif (((N1==N2) && (N2==N3) && (N3==N4)) ||
                  ((N2==N3) && (N3==N4) && (N4==N5)))
                flash[:notice] = "フォーカード"
                render("home/top")
            
            #フルハウスの判定
            elsif (((N1==N2) && (N2==N3) && (N4==N5)) ||
                  ((N1==N2 && N3==N4 && N4==N5)))
                flash[:notice] = "フルハウス"
                render("home/top")
            
            #フラッシュの判定
            elsif ((A1==A2) && (A2==A3) && (A3==A4) && (A4==A5))
                flash[:notice] = "フラッシュ"
                render("home/top")
            
            #ストレートの判定
            elsif ((N2==N1+1) && (N3==N1+2) && (N4==N1+3) && (N5==N1+4)) ||
                  ((N1==1) && (N2==10) && (N3==11) && (N4==12) && (N5==13)) ||
                  ((N1==1) && (N2==2) && (N3==11) && (N4==12) && (N5==13)) ||
                  ((N1==1) && (N2==2) && (N3==3) && (N4==12) && (N5==13)) ||
               ((N1==1) && (N2==2) && (N3==3) && (N4==4) && (N5==13)) 
                flash[:notice] = "ストレート"
                render("home/top")
                
            #スリーカードの判定
            elsif (((N1==N2) && (N2==N3)) ||
                  ((N2==N3) && (N3==N4)) ||
                  ((N3==N4) && (N4==N5)))
                flash[:notice] = "スリーカード"
                render("home/top")
                
            #ツーペアの判定
            elsif (((N1==N2) && (N3==N4)) ||
                  ((N1==N2) && (N4==N5)) ||
                  ((N2==N3) && (N4==N5)))
                flash[:notice] = "ツーペア"
                render("home/top")
                
            #ワンペアの判定
            elsif ((N1==N2) || (N2==N3) || (N3==N4) || (N4==N5))
                flash[:notice] = "ワンペア"
                render("home/top")
                
            else
                flash[:notice] = "ハイカード"
                render("home/top")
            end
            
      else
        flash[:notice] = "5つのカード指定文字を半角スペース区切りで入力してください。<br>・スペード：S<br>・ダイヤ：D<br>・ハート：H<br>・クローバー：C<br>・数字：1~13<br>(例)S1 H3 D9 C13 S11"
        render("home/top")
      end
        
        
  end
  
end