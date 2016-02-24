class RenameStatusToStateForPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :status, :state
  end
end
