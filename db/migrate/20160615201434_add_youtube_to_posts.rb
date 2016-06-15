class AddYoutubeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :youtube_videos, :text
  end
end
