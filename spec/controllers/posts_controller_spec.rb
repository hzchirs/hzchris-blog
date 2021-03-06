require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:admin_user) { create(:user, :admin) }
  let(:normal_user) { create(:user, :normal) }
  let(:other_user) { create(:user, :other) }
  let(:user_with_public_posts) { create(:user, :normal, :with_public_posts) }
  let(:user_with_private_posts) { create(:user, :normal, :with_private_posts) }

  describe "GET #index" do
    before(:each) do
      sign_in user_with_public_posts
    end

    it "assigns @posts" do
      get :index
      expect(assigns(:posts).size).to eq 2
    end

    it "can not see other user's private post" do
      create_list :post, 2, :private, author: other_user
      get :index

      expect(Post.count).to eq(4)
      expect(assigns(:posts).size).to eq 2
    end

    it "has status :success" do
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe "GET #show" do
    before(:each) do
      sign_in user_with_public_posts
      @post = user_with_public_posts.posts.first
    end

    it "assigns @post" do
      get :show, id: @post
      expect(assigns(:post)).to eq(@post)
    end

    it "redirect to :post_with_slug when path without slug" do
      get :show, id: @post
      expect(response).to redirect_to(post_with_slug_url(id: @post.id, slug: @post.slug))
    end

    it "has status :success when path with slug" do
      get :show, id: @post, slug: @post.slug
      expect(response).to have_http_status :success
    end
  end

  describe "GET #new" do
    it "redirect to sign_in page when not signed in" do
      get :new
      expect(response).to redirect_to :new_user_session
    end

    it "has status :success when signed in" do
      sign_in normal_user
      expect(response).to have_http_status :success
    end
  end
end

