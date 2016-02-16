class PostsController < ApplicationController
  def index
    if params[:name]
      @posts = Category.find_by(name: params[:name]).posts
    else
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
    @categories = Category.select(:id, :name)

    if !params[:slug] or @post.slug != params[:slug]
      redirect_to post_with_slug_url(id: @post.id, slug: @post.slug)
    end

    set_meta_tags title: @post.title,
      description: @post.plain_content
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      flash[:info] = "新增失敗"
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(
      :title, :content, :posted_at
    )
  end
end
