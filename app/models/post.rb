class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :status, presence: true

  before_save :generate_slug, :generate_excerpt

  belongs_to :category, counter_cache: true
  belongs_to :author, class_name: "User"

  default_scope { order(updated_at: :desc) }
  scope :published, -> { where(status: 'publish') }
  scope :with_category, -> (category_name) { includes(:category).all.select { |post| post.category.name == category_name } }

  def self.status
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
    self.status == 'publish'
  end

  def draft?
    self.status == 'draft'
  end

  def private?
    self.status == 'private'
  end
end
