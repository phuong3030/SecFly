json.array!(@admin_resources) do |admin_resource|
  json.extract! admin_resource, :id, :name, :description, :type
  json.url admin_resource_url(admin_resource, format: :json)
end
