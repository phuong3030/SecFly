class CreateAccounts < ActiveRecord::Migration
	def self.up
		create_table :accounts do |t|
			t.belongs_to :group

			t.string :email
			t.string :username
			t.string :password_hash
			t.timestamps
		end
	end

	def self.down
		drop_table :accounts
	end
end
