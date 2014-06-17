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
		orders = Order.order('created_at desc').first(5)
		if orders.size > 0
			@recently_orders = orders 
			@customers = orders.map { |e| e.customer[:name] }  
			@quantity = orders.map { 
				|e| e[:adult_names].split(';').size + e[:children_names].split(';').size + e[:infant_names].split(';').size 
			}
		else
			@recently_orders = []
			@customers = [] 
			@quantity = 0
		end
		if I18n.locale == :en
			render :template => 'home/services/travel_en'
		elsif I18n.locale == :vi
			render :template => 'home/services/travel_vi'
		end
	end

	# POST /travel
	def request_ticket
		# Check all name are empty
		if (params[:adult_names] == '' && params[:children_names] == '' && params[:infant_names] == '')
			flash[:alert] = 'Your request is created failed! Please try again later.'
			redirect_to travel_path 
		else
			# Just get, check customer information, store to database and subcribe to websocket channel 
			customer = Customer.new({ 
				:email => params[:email], 
				:phone => params[:phone], 
				:name => params[:name] 
			})
			order = Order.new({ 
				:from => params[:from], 
				:to => params[:to],
				:depart_date => params[:depart],
				:depart_time_slot => params[:departtime],
				:return_date => params[:return],
				:return_time_slot => params[:returntime],
				:adult_names => params[:adult_names],
				:children_names => params[:children_names],
				:infant_names => params[:infant_names],
				:payment_method => params[:payment_method]
			})
			customer.orders << order	

			if customer.save
				# subcribe to company to process your request
				WebsocketRails[:orders_management_emp].trigger(:new_request, { :customer => customer, :order => order }) 
				WebsocketRails[:orders_management_man].trigger(:new_request, { :customer => customer, :order => order }) 

				flash[:notice] = 'Thank you for using our services. We have received your request and will sent confirmation email to you.'
				redirect_to travel_path 
			else 
				flash[:alert] = 'Your request is created failed! Please try again later.'
				redirect_to travel_path 
			end
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
