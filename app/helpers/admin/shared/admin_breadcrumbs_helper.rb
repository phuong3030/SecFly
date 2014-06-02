module Admin
	module Shared
		module AdminBreadcrumbsHelper

			def create_breadcrumbs(links)

				ul_content = content_tag(
					:li, 
					(link_to admin_dashboard_index_path do 
						content_tag :i, nil, :class => 'fa fa-home'
					end)
				)

				content_tag(:ul, :class => 'breadcrumb') do 

					(0...links.length - 1).step(1) do |i|
						ul_content << (content_tag :li, link_to(links[i][:name], links[i][:path]))
					end

					(ul_content + (content_tag :li, links[links.length - 1][:name])).html_safe
				end
				
			end

		end
	end
end
