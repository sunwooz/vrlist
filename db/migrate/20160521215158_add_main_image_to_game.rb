class AddMainImageToGame < ActiveRecord::Migration
  def change
    add_attachment :games, :main_image
  end
end
