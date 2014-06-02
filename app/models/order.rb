class Order < ActiveRecord::Base
	belongs_to :customers
   has_many :accounts, :through => :order_processings 
end
