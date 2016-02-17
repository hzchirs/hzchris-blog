class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update]

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

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_with_slug_url(id: @post.id, slug: @post.slug)
  end

  private

  def find_post
    if params[:id]
      @post = Post.find(params[:id])
    else
      redirect_to :index
    end
  end

  def post_params
    params.require(:post).permit(
      :title, :content, :category_id, :posted_at
    )
  end
end
