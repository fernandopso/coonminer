class CreateNewsletter < ActiveRecord::Migration[5.1]
  def change
    create_table :newsletters do |t|
      t.string :email
      t.references :token, foreign_key: true, null: false
    end
  end
end
