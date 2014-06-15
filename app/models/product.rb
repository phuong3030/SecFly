class Product < ActiveRecord::Base

	belongs_to :category

	validates :name, :presence => true
   validates :name, uniqueness: { case_sensitive: false }

	has_attached_file :image, :style => { :medium => "300x300" }, 
		:path => ":rails_root/public/images/product_image/:id/:basename.:extension",
		:url => "/images/product_image/:id/:basename.:extension"
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	validates_attachment_size :image, :less_than => 3.megabytes
	
	def to_param
		name
	end

end
