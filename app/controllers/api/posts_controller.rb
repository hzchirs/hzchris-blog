class Api::PostsController < ApplicationController
  before_action :find_post, only: [:update]

  def update
    if @post.update_attributes(post_params)
      render json: {
        post: @post
      }, status: :ok #200
    else
      render status: :bad_request #400
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
      :title, :content, :posted_at
    )
  end
end
