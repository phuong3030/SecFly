class CreateAccountInRoles < ActiveRecord::Migration
	def self.up
		create_table :account_in_roles, :id => false do |t|
			t.integer :account_id
			t.integer :role_id
			t.text :description
		end

		add_index :account_in_roles, :account_id
		add_index :account_in_roles, :role_id
	end

	def self.down
		drop_table :user_in_roles
	end
end
