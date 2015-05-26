class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :subject
      t.text :content
      t.datetime :release_date
      t.string :tags
      t.integer :user_id
      t.boolean :published

      t.timestamps
    end
  end
end
