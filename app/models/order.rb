class Order < ActiveRecord::Base
	belongs_to :customer
   has_many :accounts, :through => :order_processings
   has_many :order_processings, :dependent => :destroy, :autosave => true

   acts_as_xlsx

	validates_presence_of(
		self.column_names - [
			"id", 
			"adult_names", 
			"children_names", 
			"infant_names", 
			"return_date",  
			"created_at", 
			"updated_at", 
			"customer_id"]
	)
	validate :depart_date_cannot_be_greater_than_return_date 

	scope :report_by_emp_date_range, 
		lambda { |start_time, end_time, emp_id|		
			joins[:account].
			where('created_at >= ? and created_at <= ? and status = 3 and account.id = ?', start_time, end_time + 1, emp_id). 
		 	order('created_at desc') }

	scope :filter_by_date_range_status, 
		lambda { |start_time, end_time, status = 0| 
			where('created_at >= ? and created_at <= ? and status = ?', start_time, end_time + 1, status). 
		 	order('created_at desc') }

	scope :filter_by_status, 
		lambda { |status = 0|
			where('status = ?', status).
			order('created_at desc') }

	def depart_date_cannot_be_greater_than_return_date
		if (return_date)
			if depart_date > return_date
				errors.add(:depart_date, "can't be greater than return date")
			end
		end
	end
end
