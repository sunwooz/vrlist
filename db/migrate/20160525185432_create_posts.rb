class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.text :body_html
      t.string :slug
      t.text :short
      t.timestamps null: false
    end
  end
end
