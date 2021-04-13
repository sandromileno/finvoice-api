class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.uuid :key, unique: true, null: false
      t.string :full_name, limit: 50, null: false
      t.string :document, limit: 30, unique: true, null: false
      t.timestamps null: false
    end
    add_reference :customers, :user, null: false, foreign_key: true, type: :bigint
    add_index :customers, :key, unique: true
  end
end
