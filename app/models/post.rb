class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :state, presence: true

  before_save :generate_slug, :generate_excerpt

  belongs_to :category, counter_cache: true
  belongs_to :author, class_name: "User"

  default_scope { order(posted_at: :desc) }
  scope :published, -> { where(state: 'publish') }
  scope :financial, -> { Category.find_by(name: '理財').posts }
  scope :programming, -> { Category.find_by(name: '程式').posts }

  def self.state
    {
      draft: '草稿',
      publish: '公開',
      private: '私密'
    }
  end

  def generate_slug
    self.slug = title.to_slug.normalize.to_s
  end

  require 'redcarpet/render_strip'
  def generate_excerpt
    unless content.nil?
      md = Redcarpet::Markdown.new(Redcarpet::Render::StripDown)
      self.plain_content = md.render(self.content)
    end
  end

  def publish?
    self.state == 'publish'
  end

  def draft?
    self.state == 'draft'
  end

  def private?
    self.state == 'private'
  end
end
