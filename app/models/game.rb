class Game < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :genres
  ratyrate_rateable "rating"

  has_attached_file :main_image, styles: { large: "1555×1037", medium: "394x262#" }
  validates_attachment_content_type :main_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_uniqueness_of :name
end
