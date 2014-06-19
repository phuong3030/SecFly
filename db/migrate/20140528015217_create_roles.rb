class CreateRoles < ActiveRecord::Migration
	def self.up
		create_table :roles do |t|
			t.integer :role_type
			t.text :description
		end
	end

	def self.down
		drop_table :roles
	end
end
