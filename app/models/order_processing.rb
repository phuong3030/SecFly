class OrderProcessing < ActiveRecord::Base

	belongs_to :order
	belongs_to :account

end
