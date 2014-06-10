class CreateOrders < ActiveRecord::Migration
	def self.up
		create_table :orders do |t|
			t.belongs_to :customer

			t.text :name
			t.text :from
			t.text :to
			t.date :depart_date
			t.integer :depart_time_slot
			t.date :return_date
			t.text :adult_names
			t.text :children_names
			t.text :infant_names
			t.integer :return_time_slot
			t.integer :payment_method
			t.integer :status, :default => 0
			t.timestamps
		end
	end

	def self.down
		drop_table :orders
	end
end
