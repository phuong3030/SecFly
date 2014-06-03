class CreateOrderProcessings < ActiveRecord::Migration
	def self.up
		create_table :order_processings, :id => false do |t|
			t.integer :order_id
			t.integer :account_id
			t.integer :status
			t.text :description
			t.timestamps
		end

		add_index :order_processings, :order_id 
		add_index :order_processings, :account_id 

		remove_column :orders, :accounts
	end

	def self.down
		add_column :orders, :accounts
		drop_table :order_processions 
	end
end
