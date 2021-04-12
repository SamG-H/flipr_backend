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
    @stack = Stack.new(stack_params)
    @stack.user = User.first
    if @stack.save
      json_response(StackSerializer.new(@stack), :created)
    else
      json_respone("Error")
    end
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
