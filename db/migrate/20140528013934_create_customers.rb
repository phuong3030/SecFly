class CreateCustomers < ActiveRecord::Migration
	def self.up
		create_table :customers do |t|
			t.text :email
			t.text :phone
			t.text :name
			t.string :group_id, :default => ''
			t.timestamps
		end
	end

	def self.down
		drop_table :customers
	end
end
