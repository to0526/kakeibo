class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :day
      t.integer :kind
      t.integer :amount
      t.references :user, null: false, foreign_key: true
      t.references :payment_classification, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
