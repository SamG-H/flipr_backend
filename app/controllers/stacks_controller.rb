class StacksController < ApplicationController
  before_action :set_stack, only: [:show, :update, :destroy]
  
  def index
    @stacks = Stack.all
    options = {
      include: [:user]
    }
    json_response(StackSerializer.new(@stacks, options))
  end

  def show
    json_response(StackSerializer.new(@stack))
  end

  def create
    @stack = Stack.create!(stack_params)
    json_response(StackSerializer.new(@stack), :created)
  end

  def update
    @stack.update(stack_params)
    head :no_content
  end

  def destroy
    @stack.destroy
    head :no_content
  end

  private
  def stack_params
    params.require(:stack).permit(:title)
  end

  def set_stack
    @stack = Stack.find(params[:id])
  end
end
