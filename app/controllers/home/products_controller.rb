class Home::ProductsController < ApplicationController

	layout 'application'
	before_action :set_product, only: [:show, :edit, :update, :destroy]

	# GET /products
	def index
		@number_of_item = params[:_number_of_item] || 8
		@filtered_category_id = params[:_category_id]
		
		@categories = Category.select(:id, :name).order(:name)
		@products = Product.get_filter_paging_data(
			@filtered_category_id,
			params[:page] || 1,
			@number_of_item
		)
	end

	# GET /products/1
	def show
		@description_list = @product.description.split(/\r?\n/)
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
