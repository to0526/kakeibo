class CreatePaymentClassifications < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_classifications do |t|
      t.integer :purpose, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
