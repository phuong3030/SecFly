class Account < ActiveRecord::Base

	include PasswordHash

	belongs_to :group
	has_many :roles, :through => :account_in_roles 
	has_many :account_in_roles
	has_many :orders, :through => :order_processings 
	has_many :order_processings, :dependent => :destroy 
	accepts_nested_attributes_for :order_processings

	validates :username, :email, :password_hash, presence: true
	validates :username, :email, uniqueness: { case_sensitive: false }

	scope(
		:get_by_group, 
		lambda { 
			|group_name = 'employee'|
			joins(:group).
			where('groups.name' => group_name) 
		}
	)

	def self.create_account(username, email, password)
		password_hash = PasswordHash::create_hash(password)

		account = Account.create(
			:username => username, 
			:email => email, 
			:password_hash => password_hash
		)
	end

	def check_user_credential(password)
		PasswordHash::validate_password(password, self.password_hash)
	end

	# Todo: change the way how to store and verify user' roles
	# we will switch to CanCan gem to better 
	def get_role
		if self.roles[0]	
			self.roles[0].role_type 
		else
			0
		end
	end

end
