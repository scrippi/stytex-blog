class AddSeoNameToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :seo_name, :string
  end
end
