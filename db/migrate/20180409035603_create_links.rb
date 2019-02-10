class CreateLinks < ActiveRecord::Migration[5.1]
  def up
    create_table :links do |t|
      t.string :title
      t.string :href, null: false
      t.boolean :banned, default: false
      t.integer :df, null: false, default: 0
      t.datetime :publish_at
      t.references :token, foreign_key: true, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :links
  end
end
