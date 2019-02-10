class AddStatusToTokens < ActiveRecord::Migration[5.1]
  def change
    add_column :tokens, :status, :string
  end
end
