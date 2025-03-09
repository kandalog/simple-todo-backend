class TodosController < ApplicationController
  before_action :authenticate, only: [ :index, :show, :create, :update, :destroy ]

  def index
    todos = @current_user.todos
    render json: { todos: }
  end

  def show
    todo = @current_user.todos.find(params[:id])
    render json: { todo: }
  end

  def create
    todo = @current_user.todos.new(todo_params)

    if todo.save
      render json: { todo: }, status: :created
    else
      render json: { error: todo.errors.messages }, status: 422
    end
  end

  def update
    todo = @current_user.todos.find(params[:id])
    todo.update(is_completed: !todo.is_completed)
    render json: { todo: }
  end

  def destroy
    todo = @current_user.todos.find(params[:id])
    todo.destroy
    render json: { todo: }
  end


  private
    def todo_params
      params.require(:todo).permit(:title, :content, :is_completed)
    end
end
