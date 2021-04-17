class SetsController < ApplicationController
  def new
  end

  def create
    redirect_to sets_path if Flashcards::Sets.create(params["name"], params["content"])
  end

  def show
    @set = Flashcards::Sets.find(params["name"])
  end

  def index
    @sets = Flashcards::Sets.all
  end
end
