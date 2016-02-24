require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:publish)
  end

  test "should not save post without title" do
    @post.title = ""
    assert_not  @post.save
  end

  test "should not save post without state" do
    @post.state = ""
    assert_not @post.save
  end
end
