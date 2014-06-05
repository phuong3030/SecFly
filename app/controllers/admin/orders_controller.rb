class Admin::OrdersController < Admin::DashboardController
	# Get customer orders summary page
	def index 

	end

	# get customer orders management page for employee
	def orders_management_by_emp
		@orders = Order.all		
	end

	# get customer orders management page for manager
	def orders_management_by_man
		page = params [:page] || 1
			page = params[:page] || 1
		@number_of_item = params[:_number_of_item] || 8
		@filtered_category_id = params[:_category_id]
		
		@categories = Category.select(:id, :name).order(:name)
		if @filtered_category_id
			filtered_category = Category.find_by_id(@filtered_category_id)		
		end 

		if filtered_category && filtered_category.product.size > 0  
			@products = filtered_category.product.page(page).per(@number_of_item)
		else 
			@products = Product.all.page(page).per(@number_of_item)
		end 

	@orders = Order.all		
	end
end
