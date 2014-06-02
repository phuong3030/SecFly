class Customer < ActiveRecord::Base
	has_many :orders, :dependent => :delete_all

	validates :email, :phone, :presence => true
end
