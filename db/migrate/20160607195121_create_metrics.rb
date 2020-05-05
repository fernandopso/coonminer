class CreateMetrics < ActiveRecord::Migration[5.0]
  def change
    create_table :metrics do |t|
      t.references :token, foreign_key: true, null: false
      t.float :percent_positive
      t.float :percent_neutral
      t.float :percent_negative
      t.integer :amount
      t.integer :amount_rated
      t.integer :user_validate
      t.integer :user_rated
      t.integer :user_rated_positive
      t.integer :user_rated_neutral
      t.integer :user_rated_negative
      t.integer :svm_rated
      t.integer :svm_rated_positive
      t.integer :svm_rated_neutral
      t.integer :svm_rated_negative
      t.integer :tweets_to_delete
      t.integer :last_3_hours
      t.integer :last_12_hours
      t.integer :last_24_hours
      t.integer :last_3_days
      t.integer :last_7_days
      t.integer :positive
      t.integer :neutral
      t.integer :negative

      t.timestamps null: false
    end
  end
end
