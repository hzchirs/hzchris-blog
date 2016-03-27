class RenameStateToStatusForPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :state, :status
  end
end
