class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:name]
      @posts = policy_scope(Category.find_by(name: params[:name]).posts)
    else
      @posts = policy_scope(Post)
    end
  end

  def show
    if !params[:slug] or @post.slug != params[:slug]
      redirect_to post_with_slug_url(id: @post.id, slug: @post.slug)
    end

    set_meta_tags title: @post.title,
      description: @post.plain_content
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

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
    flash[:notice] = "更新成功"
    redirect_to post_with_slug_url(id: @post.id, slug: @post.slug)
  end

  private

  def find_post
    if params[:id]
      @post = Post.find(params[:id])
      authorize @post
    else
      redirect_to :index
    end
  end

  def post_params
    params.require(:post).permit(
      :title, :content, :state, :category_id, :posted_at
    )
  end
end
