class Api::PostsController < ApplicationController
  before_action :find_post, only: [:update, :destroy]

  def update
    if @post.update_attributes(post_params)
      render json: {
        post: @post
      }, status: :ok #200
    else
      render status: :bad_request #400
    end
  end

=begin
9.7 DELETE
A successful response SHOULD be 200 (OK)
if the response includes an entity describing the status,
202 (Accepted) if the action has not yet been enacted, or
204 (No Content) if the action has been enacted but the response does not include an entity.
=end
  def destroy
    if @post.destroy
      render json: {
        post: @post
      }, status: :ok
    else
      render status: :bad_request
    end
  end

  private

  def find_post
    if params[:id]
      @post = Post.find(params[:id])
    else
      @post = Post.create(post_params)
      render json: {
        post: @post
      }, status: :created #201
    end
  end

  def post_params
    params.require(:post).permit(
      :title, :content, :posted_at
    )
  end
end
