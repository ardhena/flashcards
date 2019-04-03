class SetsController < ApplicationController
  def show
    @set = Set::Get.(id: params[:id])[:data]
  end
end
