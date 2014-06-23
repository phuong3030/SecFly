class Home::SubsidiaryController < ApplicationController

	# GET /iit-corp
	def iit_corp
		if I18n.locale == :en
			render :template => 'home/subsidiary/iit_en'
		elsif I18n.locale == :vi
			render :template => 'home/subsidiary/iit_vi'
		end
	end

end
