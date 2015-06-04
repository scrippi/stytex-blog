class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key "comments", "posts", name: "comments_post_id_fk"
    add_foreign_key "posts", "users", name: "posts_user_id_fk"
  end
end
