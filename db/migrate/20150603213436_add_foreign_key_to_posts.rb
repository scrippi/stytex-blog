class AddForeignKeyToPosts < ActiveRecord::Migration
  def change
    add_foreign_key "comments", "posts", name: "comments_post_id_fk"
  end
end
