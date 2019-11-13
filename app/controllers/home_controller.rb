class HomeController < ApplicationController
  def top
  end
  
  
  def judge
  
  @hand = params[:hand].split.sort_by {|k| k[/\d+/].to_i}
  
  self.class.const_set(:A1,@hand[0].slice(0))
  self.class.const_set(:N1,@hand[0].gsub(/[^\d]/, "").to_i) 
  self.class.const_set(:A2,@hand[1].slice(0))
  self.class.const_set(:N2,@hand[1].gsub(/[^\d]/, "").to_i) 
  self.class.const_set(:A3,@hand[2].slice(0)) 
  self.class.const_set(:N3,@hand[2].gsub(/[^\d]/, "").to_i) 
  self.class.const_set(:A4,@hand[3].slice(0)) 
  self.class.const_set(:N4,@hand[3].gsub(/[^\d]/, "").to_i) 
  self.class.const_set(:A5,@hand[4].slice(0)) 
  self.class.const_set(:N5,@hand[4].gsub(/[^\d]/, "").to_i) 
  

    #ストレートフラッシュの判定
    if ((A1==A2) && (A2==A3) && (A3==A4) && (A4==A5) &&
       (N1==N2-1) && (N1==N3-2) && (N1==N4-3) && (N1==N5-4)) 
        flash[:notice] = "ストレートフラッシュ" 
        redirect_to("/")
        
    #フォーカードの判定
    elsif (((N1==N2) && (N2==N3) && (N3==N4)) ||
          ((N2==N3) && (N3==N4) && (N4==N5)))
        flash[:notice] = "フォーカード"
        redirect_to("/")
    
    #フルハウスの判定
    elsif (((N1==N2) && (N2==N3) && (N4==N5)) ||
          ((N1==N2 && N3==N4 && N4==N5)))
        flash[:notice] = "フルハウス"
        redirect_to("/")
    
    #フラッシュの判定
    elsif ((A1==A2) && (A2==A3) && (A3==A4) && (A4==A5))
        flash[:notice] = "フラッシュ"
        redirect_to("/")
    
    #ストレートの判定
    elsif ((N2==N1+1) && (N3==N1+2) && (N4==N1+3) && (N5==N1+4))
        flash[:notice] = "ストレート"
        redirect_to("/")
        
    #スリーカードの判定
    elsif (((N1==N2) && (N2==N3)) ||
          ((N2==N3) && (N3==N4)) ||
          ((N3==N4) && (N4==N5)))
        flash[:notice] = "スリーカード"
        redirect_to("/")
        
    #ツーペアの判定
    elsif (((N1==N2) && (N3==N4)) ||
          ((N1==N2) && (N4==N5)) ||
          ((N2==N3) && (N4==N5)))
        flash[:notice] = "ツーペア"
        redirect_to("/")
        
    #ワンペアの判定
    elsif ((N1==N2) || (N2==N3) || (N3==N4) || (N4==N5))
        flash[:notice] = "ワンペア"
        redirect_to("/")
        
    else
        flash[:notice] = "ハイカード"
        redirect_to("/")
    end
    
  end
  
end




