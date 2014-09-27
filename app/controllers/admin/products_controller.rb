class Admin::ProductsController < Admin::DashboardController

	before_filter :check_role
	before_action :set_admin_product, only: [:show, :edit, :update, :destroy]

	# GET /admin/products
	def index
		@products = []
		category = Category.find_by_id(params[:category_id])

		if category
			@products = category.products
		end
	end

	# GET /admin/products/:id
	def show
	end

	# GET /admin/products/new
	def new
		@product = Product.new
	end

	# GET /admin/products/:id/edit
	def edit
	end

	# POST /admin/products
	def create
		category = Category.find_by_id(params[:category_id])
		@product = Product.new(admin_product_params)
		category.products << @product

		if category.save
			redirect_to admin_category_product_path(@product.category_id, @product.id), notice: 'Product was successfully created.' 
		else
			render 'new' 
		end
	end

	# PATCH/PUT /admin/products/:id
	def update
		if @product.update(admin_product_params)
			redirect_to admin_category_product_path(@product.category_id, @product.id), notice: 'Product was successfully updated.' 
		else
			render 'edit'
		end
	end

	# DELETE /admin/products/:id
	def destroy
		@product.destroy
		redirect_to admin_category_products_path(@product.category_id)
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_admin_product
		@product = Product.find(params[:id])

	rescue ActiveRecord::RecordNotFound
		redirect_to :controller => 'errors', :action => 'show', :code => '404' 
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def admin_product_params
		params.require(:product).permit(:name, :description, :image, :name_vi, :description_vi)
	end

	# Check role to access this controller
	def check_role
		account = Account.find_by_username(session[:current_user])

		if account.get_role > 2
			redirect_to(
				admin_dashboard_index_path, 
				:notice => "You don't have permission to access this page"
			)
		end
	end

end
