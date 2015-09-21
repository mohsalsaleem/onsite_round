class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:view_questions, :checkAnswers]
  before_action :authenticate_admin!, only: [:index, :show, :edit, :destroy, :create, :view_questions, :checkAnswers]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def view_questions
	@questions = Question.order("RANDOM()")
  end
 
  def checkAnswers
	userAnswers = params[:option]
	print userAnswers
	answers = Answer.all
	print answers.find(1).answer
	score = 0
	userAnswers.symbolize_keys()
	userAnswers.each do |uA|
		if uA[1] == answers.find(uA[0].to_i).answer
			score+=1
		end		
	end	
	print "Score is: "+score.to_s
	user = current_user
	Leaderboard.create(user_email: user.email, score: score)
	redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :option_1, :option_2, :option_3, :option_4)
    end
end
