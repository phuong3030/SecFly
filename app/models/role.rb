class Role < ActiveRecord::Base
	has_many :accounts, :through => :account_in_roles 
   has_many :account_in_roles
end
