class Post < ActiveRecord::Base
  has_many :attachments
  
  before_save :generate_body_html

  has_attached_file :image, styles: { large: "1555×1037" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  acts_as_taggable
  acts_as_taggable_on :tags

  extend FriendlyId
  friendly_id :title, use: :slugged

  def generate_body_html
    return if self.content.blank?
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(:hard_wrap => true),
      :no_intra_emphasis => true,
      :autolink => true,
      :fenced_code_blocks => true)

    self.body_html = Redcarpet::Render::SmartyPants.render(
        markdown.render(self.content).to_s
    )
  end
end
