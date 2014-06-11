class Order < ActiveRecord::Base
	belongs_to :customer
   has_many :accounts, :through => :order_processings
   has_many :order_processings, :dependent => :destroy, :autosave => true

	validates_presence_of(self.column_names - ["id", "adult_names", "children_names", "infant_names", "return_date",  "created_at", "updated_at", "customer_id"])
	validate :depart_date_cannot_be_greater_than_return_date 

	def depart_date_cannot_be_greater_than_return_date
		if (return_date)
			if depart_date > return_date
				errors.add(:depart_date, "can't be greater than return date")
			end
		end
	end
end
