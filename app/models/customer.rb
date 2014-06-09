class Customer < ActiveRecord::Base
	has_many :orders, :dependent => :delete_all

	validates_presence_of(self.column_names - ["id"])
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :phone, :numericality => { only_integer: true }, :length => { :minimum => 6, :maximum => 15 }
end
