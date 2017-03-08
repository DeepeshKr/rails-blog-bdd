class AddUserToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :user, :reference
  end
  
end
