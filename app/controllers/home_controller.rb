class HomeController < ApplicationController

include PorkerJudgeService

  def top
  end
  
  
  def judge
    @cards = params[:hand]
    @hands = JudgeHands.new(@cards)
        
    @hands.execute
    if @hands.error_messages
        flash[:notice] = @hands.error_messages
        render("home/top")
    else
        @results = @hands.result
        render("home/top")
    end
  
  end
  
end