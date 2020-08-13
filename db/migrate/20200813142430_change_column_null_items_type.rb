class ChangeColumnNullItemsType < ActiveRecord::Migration[6.0]
  def up
    execute("UPDATE items SET type = 'Payment'")
    execute("UPDATE items SET amount = amount * -1")
    change_column_null :items, :type, false
  end

  def down
    change_column_null :items, :type, true
    execute("UPDATE items SET amount = amount * -1")
    execute("UPDATE items SET type = NULL")
  end
end
