json.array!(@catalog_trademarks) do |catalog_trademark|
  json.extract! catalog_trademark, :id, :name, :description, :user_id, :company, :company_id
  json.url catalog_trademark_url(catalog_trademark, format: :json)
end
