class AddAvatarAndUsernameToTokens < ActiveRecord::Migration[5.1]
  def change
    add_column :tokens, :username, :string
    add_column :tokens, :avatar, :string
  end
end
