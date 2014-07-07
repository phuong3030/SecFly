class Admin::CategoriesController < Admin::DashboardController

	before_filter :check_role
	before_action :set_category, only: [:show, :edit, :update, :destroy]

	# GET /admin/categories
	def index
		@category = Category.all
	end

	# GET /admin/categories/:id
	def show
	end

	# GET /admin/categories/new
	def new
		@category = Category.new
	end

	# GET /admin/categories/:id/edit
	def edit
	end

	# POST /admin/categories
	def create
		@category = Category.new(category_params)

		if @category.save
			redirect_to admin_category_path(@category.id), notice: 'Category was successfully created.' 
		else
			render 'new' 
		end
	end

	# PATCH/PUT /admin/categories/:id
	def update
		if @category.update(category_params)
			redirect_to admin_category_path(@category.id), notice: 'Category was successfully updated.' 
		else
			render 'edit' 
		end
	end

	# DELETE /admin/categories/:id
	def destroy
		@category.destroy
		redirect_to admin_categories_url
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_category
		@category = Category.find(params[:id])

	rescue ActiveRecord::RecordNotFound
		redirect_to :controller => 'errors', :action => 'show', :code => '404' 
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def category_params
		params.require(:category).permit(:name, :description)
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
