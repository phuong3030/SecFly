class Admin::CategoriesController < Admin::DashboardController
	before_action :set_category, only: [:show, :edit, :update, :destroy]

	# GET /admin/categories
	# GET /admin/categories.json
	def index
		@category = Category.all
	end

	# GET /admin/categories/1
	# GET /admin/categories/1.json
	def show
	end

	# GET /admin/categories/new
	def new
		@category = Category.new
	end

	# GET /admin/categories/1/edit
	def edit
	end

	# POST /admin/categories
	# POST /admin/categories.json
	def create
		@category = Category.new(category_params)

		respond_to do |format|
			if @category.save
				format.html { redirect_to admin_category_path(@category.id), notice: 'Category was successfully created.' }
				format.json { render action: 'show', status: :created, location: @category }
			else
				format.html { render action: 'new' }
				format.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /admin/categories/1
	# PATCH/PUT /admin/categories/1.json
	def update
		respond_to do |format|
			if @category.update(category_params)
				format.html { redirect_to admin_category_path(@category.id), notice: 'Category was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /admin/categories/1
	# DELETE /admin/categories/1.json
	def destroy
		@category.destroy
		respond_to do |format|
			format.html { redirect_to admin_categories_url }
			format.json { head :no_content }
		end
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
end
