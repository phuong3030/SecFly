class Admin::ProductsController < ApplicationController
	layout "admin"
	before_filter :checkAuthorization
	before_action :set_admin_product, only: [:show, :edit, :update, :destroy]

	# GET /admin/products
	# GET /admin/products.json
	def index
		@products = []
		category = Category.find_by_id(params[:category_id])

		if category
			@products = category.product 
		end
	end

	# GET /admin/products/1
	# GET /admin/products/1.json
	def show
	end

	# GET /admin/products/new
	def new
		@product = Product.new
	end

	# GET /admin/products/1/edit
	def edit
	end

	# POST /admin/products
	# POST /admin/products.json
	def create
		category = Category.find_by_id(params[:category_id])
		@product = Product.new(admin_product_params)
		category.product << @product

		respond_to do |format|
			if category.save
				format.html { redirect_to admin_category_product_path(@product.category_id, @product.id), notice: 'Product was successfully created.' }
				format.json { render action: 'show', status: :created, location: @product }
			else
				format.html { render action: 'new' }
				format.json { render json: @product.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /admin/products/1
	# PATCH/PUT /admin/products/1.json
	def update
		respond_to do |format|
			if @product.update(admin_product_params)
				format.html { redirect_to admin_category_product_path(@product.category_id, @product.id), notice: 'Product was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @product.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /admin/products/1
	# DELETE /admin/products/1.json
	def destroy
		@product.destroy
		respond_to do |format|
			format.html { redirect_to admin_category_products_path(@product.category_id) }
			format.json { head :no_content }
		end
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
		params.require(:product).permit(:name, :description, :image)
	end

	def checkAuthorization
		redirect_to admin_login_path unless session[:logged_in] 
	end

end
