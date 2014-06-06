class CreateOrders < ActiveRecord::Migration
	def self.up
		create_table :orders do |t|
			t.belongs_to :customer

			t.text :from
			t.text :to
			t.datetime :depart
			t.datetime :return
			t.integer :adult
			t.integer :seniors
			t.integer :children
			t.integer :status, :default => 0
			t.timestamps
		end
	end

	def self.down
		drop_table :orders
	end
end
