class Order < ActiveRecord::Base
	belongs_to :customer 
   has_many :accounts, :through => :order_processings
   has_many :order_processings, :dependent => :destroy, :autosave => true
end
