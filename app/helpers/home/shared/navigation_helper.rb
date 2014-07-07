module Home
	module Shared
		module NavigationHelper
			def nav_tab(title, url, options = {})
				current_tab = options[:current]

				content_tag(
					:li, 
					link_to(t('main_nav.' + title), url), 
					options.merge(
						:class => (current_tab == title) ? 'active' : ''
					)
				)
			end

			def currently_at(tab)
				render partial: 'shared/home/main_nav', locals: { current_tab: tab }
			end
		end
	end
end
