require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to :author }
  it { should belong_to :category }
  it { should validate_presence_of :title }
  it { should validate_presence_of :status }

  let(:post) { build(:post, :publish) }

  context "when save" do
    it "should not success with blank title" do
      post.title = ''
      expect(post).not_to be_valid
      expect(post.save).to be false
    end

    it "should not success with blank status" do
      post.status = ''
      expect(post).not_to be_valid
      expect(post.save).to be false
    end

    it "should success with none blank title and status" do
      expect(post).to be_valid
      expect(post.save).to be true
    end

    it "should generate slug" do
      post.save!
      expect(post.slug).not_to be_empty
    end

    it "should generate excerpt" do
      post.save!
      expect(post.plain_content).not_to be_empty
    end
  end


end
