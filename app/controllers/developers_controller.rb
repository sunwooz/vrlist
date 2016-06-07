class DevelopersController < ApplicationController

  def show
    @developer = params[:developer]
    @games = Game.where(developer: params[:developer])
  end
end
