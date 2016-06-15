class PostsController < ApplicationController

  def index
    @posts = Post.tagged_with(params[:tag])
    if params[:tag] == 'upcoming'
      render 'upcoming'
    else
      render 'index'
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      if params[:post][:attachment]
        params[:post][:attachment][:image].each do |image|
          @post.attachments.create(image: image)
        end
      end
      redirect_to root_url
    end
  end

  def show
    @post = Post.friendly.find(params[:id])
    if @post.tags.pluck(:name).include?('upcoming')
      @youtube_videos = @post.youtube_videos.split if !@post.youtube_videos.nil?
      render layout: 'full-width-post'
    end
  end

  def destroy
    @post = Post.friendly.find(params[:id])
    if @post.destroy
      redirect_to posts_path
    end
  end

  def edit
    @post = Post.friendly.find(params[:id])
  end

  def update
    @post = Post.friendly.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :tag_list, :youtube_videos, :release_date)
  end
end
