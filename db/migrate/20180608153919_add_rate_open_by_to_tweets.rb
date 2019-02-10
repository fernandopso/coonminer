class AddRateOpenByToTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :rate_open_by, :text
  end
end
