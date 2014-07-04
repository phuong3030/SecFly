module Home 
	module Shared
		module PageHeaderHelper
			def create_breadcrumb(links)
				ol_content = ''
				content_tag(:ol, :class => 'breadcrumb') do 

					last_nav_item = t('main_nav.' + links[links.length - 1][:name])
					last_nav_item_check = (last_nav_item.include? 'class="translation_missing"') \
						? links[links.length - 1][:name] : last_nav_item

					(0...links.length - 1).step(1) do |i|
						ol_content << (content_tag :li, link_to(t('main_nav.' + links[i][:name]), links[i][:path]))
					end

					(ol_content + (content_tag :li, last_nav_item_check)).html_safe
				end
			end

			def render_page_header(header, links)
				header_translated = t('main_nav.' + header)
				render(
					'shared/home/pageheader', 
					:links => links, 
					:header => ((header_translated.include? 'class="translation_missing"') ? header \
									: header_translated).mb_chars.to_s
				)
			end
		end
	end
end

