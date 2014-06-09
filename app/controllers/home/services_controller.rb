class Home::ServicesController < ApplicationController
	before_action :set_product, only: [:show, :edit, :update, :destroy]

	# GET / index action 
	def index
		if I18n.locale == :en
			render :template => 'home/services/services_en'
		elsif I18n.locale == :vi
			render :template => 'home/services/services_vi'
		end
	end

	# GET /security-devices
	def security_devices
		if I18n.locale == :en
			render :template => 'home/services/security_devices_en'
		elsif I18n.locale == :vi
			render :template => 'home/services/security_devices_vi'
		end
	end

	# GET /travel
	def travel
		if I18n.locale == :en
			render :template => 'home/services/travel_en'
		elsif I18n.locale == :vi
			render :template => 'home/services/travel_vi'
		end
	end

	# POST /travel
	def request_ticket
		# just get, check customer information, store to database and subcribe to websocket channel 
		customer = Customer.new({ :email => params[:email], :phone => params[:phone], :name => params[:name] })
		binding.pry
		order = Order.new(
			{ 
				:from => params[:from], 
				:to => params[:to],
				:depart => params[:depart],
				:return => params[:return],
				:children => params[:children],
				:adult => params[:adult],
				:seniors => params[:senior]
			}
		)
		customer.orders << order	

		if customer.save
			# subcribe to company to process your request
			WebsocketRails[:orders_management_emp].trigger(:new_request, { :customer => customer, :order => order }) 

			flash[:notice] = 'Thank you for using our services. We have received your request and will sent confirmation email to you.'
			redirect_to travel_path 
		else 
			flash[:alert] = 'Your request is created failed! Please try again later.'
			redirect_to travel_path 
		end
	end

	# GET /personal-finance 
	def personal_finance 
		if I18n.locale == :en
			render :template => 'home/services/personal_finance_en'
		elsif I18n.locale == :vi
			render :template => 'home/services/personal_finance_vi'
		end
	end
	
end
