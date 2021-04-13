class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.uuid :key, null: false
      t.string :external_key, limit: 255, null: false
      t.decimal :amount, precision: 10, scale: 6, null: false
      t.decimal :paid, precision: 10, scale: 6, default: 0.0, null: false
      t.decimal :chargebacked, precision: 10, scale: 6, default: 0.0, null: false
      t.date :due_date, null: false
      t.string :status, limit: 12, null: false
      t.text :scan, null: true
      t.timestamps null: false
    end
    add_reference :invoices, :customer, foreign_key: true, type: :bigint
    add_index :invoices, [:external_key, :customer_id], unique: true
    add_index :invoices, :key, unique: true
  end
end
