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
			"return_time_slot",
			"updated_at", 
			"customer_id"]
	)
	validate :depart_date_cannot_be_greater_than_return_date 

	scope :report_by_emp_date_range, 
		lambda { |start_time, end_time, emp_id|		
			joins(:accounts).
			where('orders.created_at >= ? and orders.created_at <= ? and orders.status = 3 and accounts.id = ?', start_time, end_time + 1, emp_id). 
			order('orders.created_at desc') }

	scope :filter_by_date_range_status, 
		lambda { |start_time, end_time, status = 0| 
			where('created_at >= ? and created_at <= ? and status = ?', start_time, end_time + 1, status). 
		 	order('created_at desc') }

	scope :filter_by_status, 
		lambda { |status = 0|
			where('status = ?', status).
			order('created_at desc') }
	
	def self.get_filter_data(start_time, end_time, status)
		order = []

		if start_time && end_time
			orders = Order.filter_by_date_range_status(start_time.to_date, end_time.to_date, status)
		else 
			orders = Order.filter_by_status(status)
		end
	end

	def self.create_report(start_time, end_time, emp_id) 
		orders = []

		# Order filter and get data to export to excel
		if start_time && start_time != "" && end_time && end_time != ""
			if emp_id && emp_id != "" 
				orders = Order.report_by_emp_date_range(start_time.to_date, end_time.to_date, emp_id)
			else
				orders = Order.filter_by_date_range_status(start_time.to_date, end_time.to_date, 3)
			end
		else
			if emp_id && emp_id != "" 
				orders = Order.report_by_emp_date_range(30.days.ago, Date.today, emp_id)
			else
				orders = Order.filter_by_date_range_status(30.days.ago, Date.today, 3)
			end
		end
	end

	def depart_date_cannot_be_greater_than_return_date
		if (return_date)
			if depart_date > return_date
				errors.add(:depart_date, "can't be greater than return date")
			end
		end
	end

end
