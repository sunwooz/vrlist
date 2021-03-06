class GamesController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :genres, only: [:new, :edit]
  before_action :redirect_if_not_admin, only: [:new, :edit, :destroy]

  def new
    @game = Game.new
  end

  def index
    page = check_page

    if !params[:genres] && !params[:categories]
      @games = Game.paginate(:page => page, :per_page => 6).latest
      respond_to do |format|
        format.js { render layout: false }
        format.html
      end
    else
      if !params[:genres]
        @games = Game.where(category: params[:categories]).paginate(:page => page, :per_page => 6).latest
      elsif !params[:categories]
        @games = Game.tagged_with(params[:genres]).paginate(:page => page, :per_page => 6).latest
      else
        @games = Game.where(category: params[:categories]).tagged_with(params[:genres]).paginate(:page => page, :per_page => 6).latest
      end
      respond_to do |format|
        format.js { render layout: false }
        format.html
      end
    end
  end

  def link_index
    @games = Game.all
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      if params[:game][:attachment]
        params[:game][:attachment][:image].each do |image|
          @game.attachments.create(image: image)
        end
      end
      redirect_to @game
    else
      render :new
    end
  end

  def show
    @game = Game.friendly.find(params[:id])
    @youtube_videos = @game.youtube_videos.split if !@game.youtube_videos.nil?
    @tags_list = @game.genre_list.split(',')[0]

    #filter genre list - features/genres/free(paid)
    features = ['free', 'paid', 'single-player', 'multi-player', 'internet-required', 'gamepad-required', 'gamepad-support', 'touchpad-support']

    @price_tag = @tags_list.include?('free') ? 'free' : 'paid'
    @genre_tags = (@tags_list - features)
    @feature_tags = @tags_list.select { |genre| features.include?(genre) } - ['free', 'paid']
    render layout: 'full-width'
  end

  def edit
    @game = Game.friendly.find(params[:id])
  end

  def update
    @game = Game.friendly.find(params[:id])
    if @game.update(game_params)
      if params[:game][:attachment]
        params[:game][:attachment][:image].each do |image|
          @game.attachments.create(image: image)
        end
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
    params.require(:game).permit(:name, :date_developed, :detail, :developer, :genre_list, :category, :main_image, :thumbnail, :website, :price, :youtube_videos)
  end

  def genres
    @genres = %w(action simulation educational horror adventure exploration rpg casual puzzle narrative arcade shooter movie music video utilities sports productivity music arcade racing fighting strategy).sort
  end

  def check_page
    p = params[:page].to_i
    p > 1 ? p : 1
  end

  def redirect_if_not_admin
    redirect_to root_url if current_user && current_user.email != 'yangsunwoo@gmail.com'
  end
end
