class CreateToken < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.string :uuid, unique: true, null: false
      t.string :word, null: false
      t.string :lang
      t.string :accuracy
      t.string :category
      t.boolean :public, default: true
      t.datetime :tf_idf_at
      t.datetime :svm_rated_at
      t.datetime :collect_at
      t.datetime :publish_at
      t.boolean :enable, default: true
      t.boolean :keep_cron_crawler, default: true
      t.boolean :publishable, default: false
      t.integer :company_id
      t.timestamps null: false
    end

    add_index :tokens, :word
    add_index :tokens, :uuid
  end
end
