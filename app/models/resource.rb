class Resource < ActiveRecord::Base

	has_attached_file :image, :style => { :medium => "300x300" }, 
		:path => ":rails_root/public/images/resources_image/:basename.:extension",
		:url => "/images/resources_image/:basename.:extension"
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	validates_attachment_size :image, :less_than => 3.megabytes

	validates :name, :presence => true
	validates :name, uniqueness: { case_sensitive: false }

	scope :get_sale_banner, -> { where(:resource_type => 2) }
	scope :get_sale_text, -> { where(:resource_type => 3) }
end
