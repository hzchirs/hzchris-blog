require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  def setup
    @admin_user = users(:chris)
    @normal_user = users(:joyce)
    @publish_post = posts(:publish)
    @private_post = posts(:private)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to :new_user_session
  end

  test "should redirect show when post state is private" do
    get(:show, id: @private_post)
    assert_redirected_to :root
  end

  test "should redirect show when post state is private with normal user" do
    sign_in @normal_user
    get(:show, id: @private_post)
    assert_redirected_to :root
  end

  test "should get show of private post when user is admin" do
    sign_in @admin_user
    get(:show, id: @private_post, slug: @private_post.slug)
    assert_response :success
  end

  test "should redirect show when params without slug" do
    get :show, id: @publish_post
    assert_redirected_to post_with_slug_url(id: @publish_post, slug: @publish_post.slug)
  end

  test "should get show when post state is publish" do
    get(:show, id: @publish_post, slug: @publish_post.slug)
    assert_response :success
  end
end
