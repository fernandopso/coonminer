class AddMetrics < ActiveRecord::Migration[6.0]
  def change
    add_column :metrics, :tweets, :integer
    add_column :metrics, :locations, :integer
    add_column :metrics, :hashtags, :integer
    add_column :metrics, :mentions, :integer
    add_column :metrics, :languages, :integer
    add_column :metrics, :links, :integer
    add_column :metrics, :users, :integer
  end
end
