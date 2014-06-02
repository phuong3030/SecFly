class CreateResources < ActiveRecord::Migration
	def self.up
		create_table :resources do |t|
			t.string :name
			t.string :description
			t.integer :resource_type
			t.attachment :image
		end
	end

	def self.down
		drop_table :resources
	end
end
