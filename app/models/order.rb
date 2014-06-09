class Order < ActiveRecord::Base
	belongs_to :customer 
   has_many :accounts, :through => :order_processings
   has_many :order_processings, :dependent => :destroy, :autosave => true

	validates_presence_of(self.column_names - ["id"])
	validates :adult, :children, :infant, :numericality => { only_integer: true }
	validate :depart_date_cannot_be_greater_than_return_date 

	def depart_date_cannot_be_greater_than_return_date
		if depart_date > return_date
			errors.add(:depart_date, "can't be greater than total value")
		end
	end
end
