class CreateOrderProcessings < ActiveRecord::Migration
	def self.up
		create_table :order_processings do |t|
			t.integer :order_id
			t.integer :account_id
			t.integer :status, :null => false, :default => 1
			t.text :description
			t.timestamps
		end

		add_index :order_processings, :order_id 
		add_index :order_processings, :account_id 

	end

	def self.down
		drop_table :order_processions 
	end
end
