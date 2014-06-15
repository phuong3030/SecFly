class Home::ProductsController < ApplicationController

	layout 'application'
	before_action :set_product, only: [:show, :edit, :update, :destroy]

	# GET /products
	def index
		page = params[:page] || 1
		@number_of_item = params[:_number_of_item] || 8
		@filtered_category_id = params[:_category_id]
		
		@categories = Category.select(:id, :name).order(:name)
		if @filtered_category_id
			filtered_category = Category.find_by_id(@filtered_category_id)		
		end 

		if filtered_category && filtered_category.products.size > 0  
			@products = filtered_category.products.page(page).per(@number_of_item)
		else 
			@products = Product.all.page(page).per(@number_of_item)
		end 
	end

	# GET /products/1
	def show
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_product
		@product = Product.find_by_name!(params[:id].tr('-', ' '))

		rescue ActiveRecord::RecordNotFound
			redirect_to :controller => 'errors', :action => 'show', :code => '404' 
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def product_params
		params.require(:product).permit(:name, :description, :category_id, :image)
	end

end
