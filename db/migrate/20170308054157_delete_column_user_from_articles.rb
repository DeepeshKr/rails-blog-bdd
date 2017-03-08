class DeleteColumnUserFromArticles < ActiveRecord::Migration[5.0]
  def change
    remove_column :articles, :user
  end
end
