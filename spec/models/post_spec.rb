require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to :author }
  it { should belong_to :category }
  it { should validate_presence_of :title }
  it { should validate_presence_of :state }

  context "when save" do
    subject(:post) { Post.new({ title: '123', state: 'publish' }) }

    it "should not success with blank title" do
      post.title = ''
      expect(post.save).to be false
    end

    it "should not success with blank state" do
      post.state = ''
      expect(post.save).to be false
    end

    it "should success with none blank title and state" do
      expect(post.save).to be true
    end
  end
end
