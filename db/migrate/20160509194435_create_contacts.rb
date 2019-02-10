class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :name
      t.text :message
      t.timestamps null: false
    end
  end
end
