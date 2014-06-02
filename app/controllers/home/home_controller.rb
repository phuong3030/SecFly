class Home::HomeController < ApplicationController
	# GET /
	def index
		if I18n.locale == :en
			render :template => 'home/index/index_en'
		elsif I18n.locale == :vi
			render :template => 'home/index/index_vi'
		end
	end

	# GET /about
	def about
		if I18n.locale == :en
			render :template => 'home/about/about_en'
		elsif I18n.locale == :vi
			render :template => 'home/about/about_vi'
		end
	end

	# GET /contacts
	def contacts
		if I18n.locale == :en
			render :template => 'home/contacts/contacts_en'
		elsif I18n.locale == :vi
			render :template => 'home/contacts/contacts_vi'
		end
	end

	# GET /sitemap
	def sitemap
		respond_to do |format|
			#format :html { render :template => 'home/sitemap/sitemap' }
			format.xml do 
				
			end
		end
	end	
end
