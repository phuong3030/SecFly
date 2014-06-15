class Admin::ResourcesController < Admin::DashboardController
	before_action :set_resource, only: [:show, :edit, :update, :destroy]

	# GET /admin/resources
	# GET /admin/resources.json
	def index
		@resource = Resource.all
	end

	# GET /admin/resources/1
	def show
	end

	# GET /admin/resources/new
	def new
		@resource = Resource.new
	end

	# GET /admin/resources/1/edit
	def edit
	end

	# POST /admin/resources
	def create
		@resource = Resource.new(resource_params)

		respond_to do |format|
			if @resource.save
				format.html { redirect_to admin_resource_path(@resource.id), notice: 'Resource was successfully created.' }
			else
				format.html { render action: 'new' }
			end
		end
	end

	# PATCH/PUT /admin/resources/1
	def update
		respond_to do |format|
			if @resource.update(resource_params)
				format.html { redirect_to admin_resource_path(@resource.id), notice: 'Resource was successfully updated.' }
			else
				format.html { render action: 'edit' }
			end
		end
	end

	# DELETE /admin/resources/1
	def destroy
		@resource.destroy
		respond_to do |format|
			format.html { redirect_to admin_resources_url }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_resource
		@resource = Resource.find(params[:id])

		rescue ActiveRecord::RecordNotFound
			redirect_to :controller => 'errors', :action => 'show', :code => '404' 
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def resource_params
		params.require(:resource).permit(:name, :description, :resource_type, :image)
	end
end
