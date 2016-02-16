class Post < ActiveRecord::Base
  validates :title, presence: true
  before_save :generate_slug, :generate_excerpt

  belongs_to :category, counter_cache: true

  default_scope { order(posted_at: :desc) }
  scope :published, -> { where(status: 'published') }
  scope :financial, -> { Category.find_by(name: '理財').posts.where(status: 'published') }
  scope :programming, -> { Category.find_by(name: '程式').posts.where(status: 'published') }

  def generate_slug
    self.slug = title.to_slug.normalize.to_s
  end

  require 'redcarpet/render_strip'
  def generate_excerpt
    md = Redcarpet::Markdown.new(Redcarpet::Render::StripDown)
    self.plain_content = md.render(self.content)
  end
end
