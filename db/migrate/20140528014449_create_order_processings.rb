class CreateOrderProcessings < ActiveRecord::Migration
	def self.up
		create_table :order_processings, :id => false do |t|
			t.belongs_to :order
			t.belongs_to :account

			t.integer :status
			t.text :description
			t.timestamps
		end
	end

	def self.down
		drop_table :order_processions 
	end
end
