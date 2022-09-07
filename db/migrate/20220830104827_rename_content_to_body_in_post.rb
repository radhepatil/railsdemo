class RenameContentToBodyInPost < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :content, :body
  end
end
