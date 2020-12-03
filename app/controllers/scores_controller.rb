class ScoresController < ApplicationController
  before_action :set_stack
  before_action :set_stack_score, only: [:show, :update, :destroy]

  # GET /stacks/:stack_id/scores
  def index
    options = {
      include: [:stack]
    }
    json_response(ScoreSerializer.new(@stack.scores, options))
  end

  # GET /stacks/:stack_id/scores/:id
  def show
    json_response(ScoreSerializer.new(@score))
  end

  # POST /stacks/:stack_id/scores
  def create
    @score = @stack.scores.create!(score_params)
    json_response(ScoreSerializer.new(@score), :created)
  end

  # PUT /stacks/:stack_id/scores/:id
  def update
    @score.update(score_params)
    head :no_content
  end

  # DELETE /stacks/:stack_id/scores/:id
  def destroy
    @score.destroy
    head :no_content
  end

  private

  def score_params
    params.permit(:name, :percentage)
  end

  def set_stack
    @stack = Stack.find(params[:stack_id])
  end

  def set_stack_score
    @score = @stack.scores.find_by!(id: params[:id]) if @stack
  end
end
