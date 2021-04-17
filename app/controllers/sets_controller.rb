class SetsController < ApplicationController
  def new
  end

  def create
    redirect_to sets_path if Flashcards::Sets.create(params["name"], params["content"])
  end

  def show
    @set = Flashcards::Sets.find(params["name"])
  end

  def edit
    @set = Flashcards::Sets.find(params["name"])
  end

  def update
    redirect_to sets_path if Flashcards::Sets.update(params["name"], params["content"])
  end

  def delete
    redirect_to sets_path if Flashcards::Sets.delete(params["name"])
  end

  def index
    @sets = Flashcards::Sets.all
  end
end
