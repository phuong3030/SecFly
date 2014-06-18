class Customer < ActiveRecord::Base

	has_many :orders

	validates_presence_of(self.column_names - ["id", "group_id", "created_at", "updated_at"])
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :phone, :numericality => { only_integer: true }, :length => { :minimum => 6, :maximum => 15 }

end
