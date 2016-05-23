class AddPriceToGames < ActiveRecord::Migration
  def change
    add_column :games, :price, :string
  end
end
