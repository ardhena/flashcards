class RepositoriesController < ApplicationController
  def index
    @repository = Repository::Get.(id: nil)[:data]
  end

  def show
    @repository = Repository::Get.(id: params[:id])[:data]
    render :index
  end
end
