class Admin::ResourcesController < Admin::DashboardController

	before_filter :check_role
	before_action :set_resource, only: [:show, :edit, :update, :destroy]

	# GET /admin/resources
	def index
		@resource = Resource.all
	end

	# GET /admin/resources/:id
	def show
	end

	# GET /admin/resources/new
	def new
		@resource = Resource.new
	end

	# GET /admin/resources/:id/edit
	def edit
	end

	# POST /admin/resources
	def create
		@resource = Resource.new(resource_params)

		if @resource.save
			redirect_to admin_resource_path(@resource.id), notice: 'Resource was successfully created.'
		else
			render 'new'
		end
	end

	# PATCH/PUT /admin/resources/:id
	def update
		if @resource.update(resource_params)
			redirect_to admin_resource_path(@resource.id), notice: 'Resource was successfully updated.'
		else
			render 'edit' 
		end
	end

	# DELETE /admin/resources/:id
	def destroy
		@resource.destroy
		redirect_to admin_resources_url 
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
		params.require(:resource).permit(:name, :description, :resource_type, :image, :description_vi)
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
