module Home
	module Shared
		module RenderListProduct

			# render list products to grid
			def render_list_product(products)

				if products.size > 0 
					list_product = ''

					products.each_index do |i|
						grid_class = ' '
						grid_class << ((i + 1) % 4 == 1 ? 'first-item-in-desktop-row ' : '')
						grid_class << ((i + 1) % 2 == 1 ? 'first-item-in-tablet-row ' : '')

						list_product << (render 'home/products/product_view', :product => products[i], :grid_class => grid_class)			
					end

					list_product.html_safe
				else
					content_tag(
						:div, 
						"We don't have any products in this category", 
						:class => 'empty-notification'
					)
				end
			end

			# render categories select view for filter product later
			def render_categories_selector(categories, selected_item)
				select(
					"", 
					"category_id", 
					categories.collect {|c| [ c.name, c.id ] },
					{ 
						:prompt => t('products.Choose_category').to_s, 
						:selected => selected_item
					},
					{
						:class => 'form-control'
					}

				)	
			end

			# render number of item selector
			def render_number_of_item_selector(selected_item)
				text = t('products.items') 
				select(
					'', 
					'number_of_item', 
					[['4 ' + text , 4], ['8 ' + text , 8], ['12 ' + text, 12]],
					{ 
						:prompt => t('products.Choose_display').to_s, 
						:selected => selected_item
					},
					{
						:class => 'form-control'
					}
				)
			end
		end
	end
end
