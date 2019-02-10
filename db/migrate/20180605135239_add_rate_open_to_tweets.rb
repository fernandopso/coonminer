class AddRateOpenToTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :rate_open, :string
  end
end
