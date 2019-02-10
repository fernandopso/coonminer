class AddUuidToTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :uuid, :string
  end
end
