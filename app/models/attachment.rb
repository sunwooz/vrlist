class Attachment < ActiveRecord::Base
  belongs_to :game
  belongs_to :post
  has_attached_file :image, styles: { large: "1555x1037", medium: "575x380" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
