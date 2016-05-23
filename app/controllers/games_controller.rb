class GamesController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :edit, :destroy]

  def new
    @game = Game.new
  end

  def index
    if !params[:genres] && !params[:categories]
      @games = Game.all
      respond_to do |format|
        format.js { render layout: false }
        format.html
      end
    else
      if !params[:genres]
        @games = Game.where(category: params[:categories])
      elsif !params[:categories]
        @games = Game.tagged_with(params[:genres])
      else
        @games = Game.where(category: params[:categories]).tagged_with(params[:genres])
      end
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game
    else
      render :new
    end
  end

  def show
    @game = Game.find(params[:id])
    render layout: 'full-width'
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
      redirect_to @game
    end
  end

  def destroy
    @game = Game.find(params[:id])
    if @game.destroy
      redirect_to games_path
    end
  end

  def add_genre
    @genre = params[:genre]
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :date_developed, :detail, :developer, :genre_list, :category, :main_image, :website, :price)
  end
end
