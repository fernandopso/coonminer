class CreateMentions < ActiveRecord::Migration[5.1]
  def up
    create_table :mentions do |t|
      t.string :name, null: false
      t.integer :df, null: false, default: 0
      t.references :token, foreign_key: true, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :mentions
  end
end
