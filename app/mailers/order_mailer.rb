class OrderMailer < ActionMailer::Base

  default from: "travel@mail.nacenopto.com"

	def confirmation_order_email(to, order, customer)
		@order = order
		@customer = customer

		mail(:to => to, :subject => "Please confirm your request tickets")
    mail.deliver
	end

	def tickets_email(to)
		mail(:to => to, :subject => "Ticket(s) from Nacenopto travel agency")
    mail.deliver
	end

end
