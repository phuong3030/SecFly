class OrderMailer < ActionMailer::Base

	default from: "sir1003dem@gmail.com"

	def confirmation_order_email(to, order, customer)
		@order = order
		@customer = customer

		mail(:to => to, :subject => "Please confirm your request tickets")
	end

	def tickets_email(to)
		mail(:to => to, :subject => "Ticket(s) from Nacenopto travel agency")
	end

end
