class PostsController < ApplicationController

  def index
    @posts = Post.tagged_with(params[:tag])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_url
    end
  end

  def show
    @post = Post.friendly.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path
    end
  end

  def edit
    @post = Post.friendly.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :tag_list)
  end
end
