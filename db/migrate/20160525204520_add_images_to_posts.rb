class AddImagesToPosts < ActiveRecord::Migration
  def change
    add_attachment :posts, :image
  end
end
