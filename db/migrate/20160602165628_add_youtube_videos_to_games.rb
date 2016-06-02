class AddYoutubeVideosToGames < ActiveRecord::Migration
  def change
    add_column :games, :youtube_videos, :text
  end
end
