class Game < ActiveRecord::Base
  has_many :attachments
  accepts_nested_attributes_for :attachments

  acts_as_taggable
  acts_as_taggable_on :genres

  ratyrate_rateable "rating"

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_attached_file :main_image, styles: { large: "1555×1037", medium: "394x262#" }
  validates_attachment_content_type :main_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_attached_file :thumbnail
  validates_attachment_content_type :thumbnail, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
  validates_uniqueness_of :name


  def self.latest
    order('date_developed DESC')
  end

  def full_url
    if !website.include?('http')
      "http://#{self.website}"
    else
      self.website
    end
  end

  def dollar_price
    "$#{price}"
  end
end
