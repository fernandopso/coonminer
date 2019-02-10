class AddCategoryToTokens < ActiveRecord::Migration[5.1]
  def change
    remove_column :tokens, :category
    add_reference :tokens, :category, foreign_key: true
  end
end
