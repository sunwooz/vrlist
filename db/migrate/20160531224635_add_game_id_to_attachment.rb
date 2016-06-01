class AddGameIdToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :game_id, :integer
  end
end
