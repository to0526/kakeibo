class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.date :payed_on
      t.integer :amount
      t.references :user, null: false, foreign_key: true
      t.references :payment_classification, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
