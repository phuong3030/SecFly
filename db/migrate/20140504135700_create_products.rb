class CreateProducts < ActiveRecord::Migration
	def self.up
		create_table :products do |t|
			t.belongs_to :category

			t.string :name
			t.string :name_vi
			t.text :description
			t.text :description_vi
			t.attachment :image
			t.timestamps
		end
	end

	def self.down 
		drop_table :products
	end
end
