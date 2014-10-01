class Home::HomeController < ApplicationController

	# GET /
	def index
    @info = Resource.get_company_info
		render :template => 'home/index/index'
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
			format.xml 
		end
	end	

end
