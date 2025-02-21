class TodosController < ApplicationController
  def index
    todos = Todo.all
    render json: todos
  end

  def show
    render json: Todo.find(params[:id])
  end

  def create
    todo = Todo.new(todo_params)

    if todo.save
      render json: todo
    else
      render json: { error: todo.errors.messages }, status: 422
    end
  end

  def update
    todo = Todo.find(params[:id])
    todo.is_completed = !todo.is_completed
    todo.save
    render json: todo
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy
    render json: todo
  end


  private
    def todo_params
      params.require(:todo).permit(:title, :content, :is_completed)
    end
end
