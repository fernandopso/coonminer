class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :status
      t.timestamps null: false
    end

    add_column :users, :company_id, :integer
  end
end
