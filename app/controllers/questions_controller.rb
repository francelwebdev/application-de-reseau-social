class QuestionsController < ApplicationController
  # layout "home_page_after_user_signed_in"
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  impressionist actions: [:index, :show], unique: [:session_hash]

  # GET /questions
  # GET /questions.json
  def index
    # @questions = Question.all
    # @activities = PublicActivity::Activity.all
    @pagy, @questions = pagy(Question.all.includes(:user, :category, :answers).order(created_at: :desc), items: 1)
    # @questions = Question.includes(:user, :category, :answers).order(created_at: :desc)
    # fresh_when(@questions, public: false)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @answers = @question.answers.includes(:user)
    @question = Question.find(params[:id])
    @answer = @question.answers.build
    # fresh_when(etag: @question, last_modified: @question.updated_at, public: false)
  end

  # GET /questions/new
  def new
    @question = current_user.questions.build
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    Question.new(question_params)
    @question = current_user.questions.build(question_params)

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :description, :category_id)
    end
end
