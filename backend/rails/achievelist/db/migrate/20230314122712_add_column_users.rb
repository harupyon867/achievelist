class AddColumnUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :mail_address, :string, null: false
    add_index :users, [:mail_address], unique: true
  end
end
