class Admin::AdminController < ApplicationController

	layout 'admin'

	# Login page
	def login
		redirect_to admin_dashboard_index_path if session[:logged_in] == true
	end

	# POST create new session for user
	def create_session
		# Find existed account
		user = Account.find_by_username(params[:username])

		# Check account existed and has valid password
		if user && user.check_user_credential(params[:password])
			session[:current_user] = user.username
			session[:logged_in] = true
			redirect_to admin_dashboard_index_path
		else 
			flash[:notice] = "Invalid username or password"
			redirect_to admin_login_path
		end
	end

	# GET logout
	def logout
		if session[:logged_in]
			redirect_to admin_login_path
			flash[:notice] = "Logout successful!"
			session[:logged_in] = false
			session[:current_user] = nil
		else 
			flash[:notice] = "You haven't logged in system!"
			redirect_to admin_login_path
		end
	end

end
