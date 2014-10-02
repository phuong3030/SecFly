class OrderMailer < ActionMailer::Base

  default from: "travel@mail.nacenopto.com"

	def confirmation_order_email(to, order, customer, ticket_info)
		@order = order
		@customer = customer
    booking = ConfirmEmail.new(ticket_info)

    attachments["booking.pdf"] = { :mime_type => 'application/pdf', :content => booking.render }

		mail(:to => to, :subject => "Please confirm your request tickets")
	end

	def tickets_email(to)
		mail(:to => to, :subject => "Ticket(s) from Nacenopto travel agency")
	end

end
