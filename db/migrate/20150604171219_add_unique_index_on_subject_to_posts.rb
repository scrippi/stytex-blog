class AddUniqueIndexOnSubjectToPosts < ActiveRecord::Migration
  def change
    add_index :posts, :subject,                unique: true
  end
end
