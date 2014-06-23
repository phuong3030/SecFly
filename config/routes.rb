SecFly::Application.routes.draw do

	scope ":locale", :locale => /#{I18n.available_locales.join("|")}/ do 

		namespace :admin do

			get "/login" => "admin#login"
			post "/login" => "admin#create_session"
			post "/logout" => "admin#logout"

			resources :dashboard, :only => [:index]
			
			scope :orders do
				get "/" => "orders#index", :as => "orders"
				get "/orders-management-emp" => "orders#orders_management_by_emp"
				get "/orders-management-man" => "orders#orders_management_by_man"
				get "/orders-man-report" => "orders#orders_man_report"
			end

			resources :resources

			resources :categories do 
				resources :products
			end

			root :to => "admin#login"  

		end

		scope :module => :home, :shallow_path => "home" do

			get "/about" => "home#about"
			get "/contacts" => "home#contacts"
			scope :services do 
				get "/" => "services#index", :as => "services"
				get "/travel" => "services#travel"
				get "/personal-finance" => "services#personal_finance"
				post "/travel" => "services#request_ticket"
			end
			scope :products do
				get "/" => "products#index", :as => "products"
				get "/:id" => "products#show", :as => "show_product"
			end
			scope :subsidiary do 
				get "/iit-corporation" => "subsidiary#iit_corp", :as => "iit_corp"
			end
			#%w( 404 422 500 ).each do |code|
			#	get code, :to => "errors#show", :code => code
			#end

			root :to => "home#index"

		end

	end

	match '', to: redirect("/#{I18n.default_locale}"), :via => [:get]
	#match '^((?!websocket).)*$' => "errors#show", :code => 500, :via => [:get]

end
