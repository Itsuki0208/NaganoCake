class AddWithdrawlActiveToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :withdrawl_active, :boolean, default: true, null: false
  end
end
