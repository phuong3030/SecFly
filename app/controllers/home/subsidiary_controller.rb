class Home::SubsidiaryController < ApplicationController

	# GET /iit-corp
	def iit_corp
		if I18n.locale == :en
			render :template => 'home/subsidiary/iit_en'
		elsif I18n.locale == :vi
			render :template => 'home/subsidiary/iit_vi'
		end
	end

  # GET /travel-agency
  def travel_agency
    if I18n.locale == :en
      render :template => 'home/subsidiary/travel_agency_en'
    elsif I18n.locale == :vi
      render :template => 'home/subsidiary/travel_agency_vi'
    end
  end

  # GET /travel-agency
  def ti_solutions
    if I18n.locale == :en
      render :template => 'home/subsidiary/ti_solutions_en'
    elsif I18n.locale == :vi
      render :template => 'home/subsidiary/ti_solutions_vi'
    end
  end

end
