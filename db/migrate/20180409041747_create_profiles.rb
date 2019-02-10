class CreateProfiles < ActiveRecord::Migration[5.1]
  def up
    create_table :profiles do |t|
      t.string :name
      t.string :username, null: false
      t.string :image
      t.string :profile_image
      t.string :profile_color
      t.integer :df, null: false, default: 0
      t.integer :tweets_count
      t.integer :followers_count
      t.integer :following_count
      t.references :token, foreign_key: true, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :profiles
  end
end
