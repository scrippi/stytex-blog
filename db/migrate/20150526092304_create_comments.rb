class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.boolean :permitted
      t.integer :user_id
      t.string :author_name
      t.string :author_email

      t.timestamps
    end
  end
end
