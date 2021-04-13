class CreateChargebacks < ActiveRecord::Migration[6.1]
  def change
    create_table :chargebacks do |t|
      t.string :key, null: false
      t.decimal :amount, precision: 10, scale: 6 , null: false
      t.text :reason, null: false
      t.timestamps null: false
    end
    add_reference :chargebacks, :invoice, foreign_key: true, index: true, type: :bigint
    add_index :chargebacks, [:key, :invoice_id], unique: true
  end
end
