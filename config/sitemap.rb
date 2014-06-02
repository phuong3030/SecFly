# Set the host name for URL creation
require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = "http://www.example.com"

SitemapGenerator::Sitemap.create do
	add '/products', :changefreq => 'daily', :priority => 0.9

	add '/services', :priority => 0.9
	add '/services/security-devices', :priority => 0.8
	add '/services/travel', :priority => 0.8
	add '/services/personal-finance', :priority => 0.8

	add '/about', :priority => 0.5

	add '/contacts', :priority => 0.5

end
