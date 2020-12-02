class CardsController < ApplicationController
  before_action :set_stack
  before_action :set_stack_card, only: [:show, :update, :destroy]

  # GET /stacks/:stack_id/cards
  def index
    options = {
      include: [:stack]
    }
    json_response(CardSerializer.new(@stack.cards, options))
  end

  # GET /stacks/:stack_id/cards/:id
  def show
    json_response(CardSerializer.new(@card))
  end

  # POST /stacks/:stack_id/cards
  def create
    @card = @stack.cards.create!(card_params)
    json_response(CardSerializer.new(@card), :created)
  end

  # PUT /stacks/:stack_id/cards/:id
  def update
    @card.update(card_params)
    head :no_content
  end

  # DELETE /stacks/:stack_id/cards/:id
  def destroy
    @card.destroy
    head :no_content
  end

  private

  def card_params
    params.permit(:front, :back)
  end

  def set_stack
    @stack = Stack.find(params[:stack_id])
  end

  def set_stack_card
    @card = @stack.cards.find_by!(id: params[:id]) if @stack
  end
end
