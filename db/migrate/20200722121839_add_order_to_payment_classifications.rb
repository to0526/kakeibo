class AddOrderToPaymentClassifications < ActiveRecord::Migration[6.0]
  def up
    add_column :payment_classifications, :sort, :integer
    execute("UPDATE payment_classifications SET sort = id")
    change_column_null :payment_classifications, :sort, :false
  end

  def down
    remove_column :payment_classifications, :sort
  end
end
