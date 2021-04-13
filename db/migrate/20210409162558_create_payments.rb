class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :key, null: false
      t.decimal :amount, precision: 10, scale: 6 , null: false
      t.timestamps null: false
    end
    add_reference :payments, :invoice, foreign_key: true, index: true, type: :bigint
    add_index :payments, [:key, :invoice_id], unique: true
  end
end
