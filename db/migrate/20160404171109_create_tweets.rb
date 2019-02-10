class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.integer :token_id
      t.text :text, null: false
      t.string :url, null: false
      t.string :username
      t.string :lang
      t.string :location
      t.string :place
      t.text :geo, array: true
      t.text :bag_of_words, array: true, default: []
      t.text :bag_of_hashtags, array: true, default: []
      t.text :bag_of_mentions, array: true, default: []
      t.text :bag_of_links, array: true, default: []
      t.text :tf_idfs, array: true, default: []
      t.string :rate
      t.boolean :reply, default: false
      t.boolean :retweet, default: false
      t.string :rate_svm
      t.boolean :svm_rate_validate
      t.datetime :publish_at
      t.timestamps
    end

    add_index :tweets, :token_id
  end
end
