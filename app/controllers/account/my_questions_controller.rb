class Account::MyQuestionsController < ApplicationController
  def index
    @my_questions = current_user.questions.includes(:category, :answers)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
