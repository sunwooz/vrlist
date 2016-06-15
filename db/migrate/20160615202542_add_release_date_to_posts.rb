class AddReleaseDateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :release_date, :datetime
  end
end
