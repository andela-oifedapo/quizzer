class WelcomeController < ApplicationController
  
  def index
    @quiz = Quiz.last
    if !@quiz.blank?
      #code
      session[:current_quiz] = @quiz.id
    end
    
    
  end

  
  
end
