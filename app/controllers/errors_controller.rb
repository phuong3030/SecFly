class ErrorsController < ApplicationController

	def show
		render(
			:template => 'errors/' + status_code.to_s + '.html.erb', 
			:status => status_code,
			:layout => false
		)
	end

	protected

	def status_code
		params[:code] || 500
	end

end
