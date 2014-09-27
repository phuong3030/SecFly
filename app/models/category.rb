class Category < ActiveRecord::Base

  has_many :products

  validates :name, :presence => true
  validates :name, uniqueness: { case_sensitive: false }

  def name
    if I18n.locale == :en
      read_attribute(:name)
    else 
      read_attribute(:name_vi)
    end
  end

end
