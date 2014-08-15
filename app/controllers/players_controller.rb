class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:[:new, :create, :start_quiz]#add for play as well later



  # GET /players
  # GET /players.json
  def start_quiz()
    if Player.where("user" =>current_user, "quiz_id" => session[:current_quiz]).blank?
      #code
      @player = Player.new("progress" =>0, "score" =>0)
    else
      @player = Player.where("user" =>current_user, "quiz_id" => session[:current_quiz]).last
    end
    @quiz = Quiz.find(session[:current_quiz])
    @player.quiz = @quiz
    @player.user = current_user
    @player.save
    
    @question = Question.where("quiz_id" =>@player.quiz_id, "question_number" =>@player.progress+1).last
    #session[:current_question] = @question
    respond_to do |format|
      if Question.where("quiz_id" =>@player.quiz_id, "question_number" =>@player.progress+1).last.blank?
        format.html { redirect_to "/dash_board", notice: 'Quiz Completed.' }
      else
        format.html { render :answer_question }
      end
    end
  end
  
  
  
  def dash_board
    @players = Player.where('user' =>current_user)
  end
  
  def record_progress
    @player = Player.where('quiz_id' =>session[:current_quiz], 'user' =>current_user)
    @player = @player.first
    @question = Question.where("quiz_id" =>@player.quiz_id, "question_number" =>@player.progress+1).last
    if record_params[:user_answer] == @question.answer
      @player.score = @player.score + 1
    end
    @player.progress =@player.progress + 1
    @player.save
    @question = Question.where("quiz_id" =>@player.quiz_id, "question_number" =>@player.progress+1).last
    #add if conditionals to see if there are questions left
    respond_to do |format|
      if @question.blank?
        format.html { redirect_to "/dash_board", notice: 'Quiz Completed.' } #this should go to dashboard
      else
        format.html { render :answer_question }
      end
    end
  end


  
  def answer_question
    @player = Player.where("quiz_id" =>session[:current_quiz], "user" =>current_user)
    @question = Question.where("quiz_id" =>@player.first.quiz_id, "question" =>@player.first.progress+1).last
    session[:current_question] = 12
  end
  
  
  
  
  

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new()
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:quiz_id, :user_id, :score, :progress)
    end
    
    def record_params
      params.permit(:user_answer)
    end
end
