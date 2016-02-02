class Post < ActiveRecord::Base
  validates :title, presence: true
  belongs_to :category, counter_cache: true

  default_scope { order(posted_at: :desc) }
  scope :published, -> { where(status: 'published') }
  scope :financial, -> { Category.find_by(name: '理財').posts.where(status: 'published') }
  scope :programming, -> { Category.find_by(name: '程式').posts.where(status: 'published') }
end
