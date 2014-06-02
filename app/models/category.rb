class Category < ActiveRecord::Base
	has_many :product

	validates :name, :presence => true
   validates :name, uniqueness: { case_sensitive: false }
end
