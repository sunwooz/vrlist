class AddMediaAttachmentToGame < ActiveRecord::Migration
  def change
    add_attachment :games, :media
  end
end
