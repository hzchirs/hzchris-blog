require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @admin_user = users(:chris)
    @normal_user_with_private_post = users(:joyce)
    @normal_user_with_draft_post = users(:jane)
    @publish_post = posts(:publish)
    @private_post = posts(:private)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should redirect new when not signed in" do
    get :new
    assert_redirected_to :new_user_session
  end

  test "should get new when signed in" do
    sign_in @normal_user_with_private_post
    get :new
    assert_response :success
  end

  test "should redirect update when not signed in" do
    patch(:update, id: @publish_post, post: { title: 'test' })
    assert_not flash.empty?
    assert_redirected_to :root
  end

  test "should patch update when user is post owner" do
    sign_in @normal_user_with_private_post
    patch(:update, id: @private_post, post: { title: 'test' })
    assert_redirected_to post_with_slug_url(id: @private_post, slug: 'test')
  end

  test "should redirect show when post state is private" do
    get(:show, id: @private_post)
    assert_redirected_to :root
  end

  test "should redirect show when post state is private with wrong user" do
    sign_in @normal_user_with_draft_post
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

  test "should redirect create when not signed in" do
    assert_no_difference('Post.count') do
      post(:create, post: { title: 'test', content: 'content', state: 'private' })
    end

    assert_not flash.empty?
    assert_redirected_to :new_user_session
  end

  test "should post create when signed in" do
    sign_in @normal_user_with_draft_post
    assert_difference('Post.count') do
      post(:create, post: { title: 'test', content: 'content', state: 'private' })
    end

    assert_redirected_to post_url(assigns(:post))
  end
end
