class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.datetime :date_developed
      t.string :developer
      t.timestamps null: false
    end
  end
end
