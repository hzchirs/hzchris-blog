class AddPlainContentToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :plain_content, :text
  end
end
