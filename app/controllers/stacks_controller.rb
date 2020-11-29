class StacksController < ApplicationController
  before_action :set_stack, only: [:show, :update, :destroy]
  
  def index
    @stacks = Stack.all
    json_response(@stacks)
  end

  def show
    json_response(@stack)
  end

  def create
    @stack = Stack.create!(stack_params)
    json_response(@stack, :created)
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
    params.permit(:title)
  end

  def set_stack
    @stack = Stack.find(params[:id])
  end
end
