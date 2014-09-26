class Product < ActiveRecord::Base

	belongs_to :category

	validates :name, :presence => true
	validates :name, uniqueness: { case_sensitive: false }

	has_attached_file :image, :style => { :medium => "300x300" }, 
		:path => ":rails_root/public/images/product_image/:id/:basename.:extension",
		:url => "/images/product_image/:id/:basename.:extension"

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	validates_attachment_size :image, :less_than => 3.megabytes

	def self.get_filter_paging_data(filtered_category_id, page, number_of_item) 
		products = []

		if filtered_category_id
			filtered_category = Category.find_by_id(filtered_category_id)
		end 

		if filtered_category && filtered_category.products.size > 0  
			products = filtered_category.products.page(page).per(number_of_item)
		else 
			products = Product.all.page(page).per(number_of_item)
		end
	end

	def to_param
		name
	end

  def name
    if I18n.locale == :en
      read_attribute(:name)
    else 
      read_attribute(:name_vi)
    end
  end

  def description
    if I18n.locale == :en
      read_attribute(:description)
    else 
      read_attribute(:description_vi)
    end

  end

end
