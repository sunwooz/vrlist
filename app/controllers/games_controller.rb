class GamesController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :genres, only: [:new, :edit]

  def new
    @game = Game.new
  end

  def index
    page = check_page

    if !params[:genres] && !params[:categories]
      @games = Game.paginate(:page => page, :per_page => 6)
      respond_to do |format|
        format.js { render layout: false }
        format.html
      end
    else
      if !params[:genres]
        @games = Game.where(category: params[:categories]).paginate(:page => page, :per_page => 6)
      elsif !params[:categories]
        @games = Game.tagged_with(params[:genres]).paginate(:page => page, :per_page => 6)
      else
        @games = Game.where(category: params[:categories]).tagged_with(params[:genres]).paginate(:page => page, :per_page => 6)
      end
      respond_to do |format|
        format.js { render layout: false }
        format.html
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
    @game = Game.friendly.find(params[:id])
    @youtube_videos = @game.youtube_videos.split if !@game.youtube_videos.nil?
    render layout: 'full-width'
  end

  def edit
    @game = Game.friendly.find(params[:id])
  end

  def update
    @game = Game.friendly.find(params[:id])
    if @game.update(game_params) && params[:game][:attachment]
      params[:game][:attachment][:image].each do |image|
        @game.attachments.create(image: image)
      end
    end
    redirect_to @game
  end

  def destroy
    @game = Game.friendly.find(params[:id])
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
    params.require(:game).permit(:name, :date_developed, :detail, :developer, :genre_list, :category, :main_image, :website, :price, :youtube_videos)
  end

  def genres
    @genres = %w(action simulation educational horror adventure exploration rpg casual puzzle narrative arcade shooter movie music video utilities sports productivity music arcade racing fighting strategy).sort
  end

  def check_page
    p = params[:page].to_i
    p > 1 ? p : 1
  end
end
