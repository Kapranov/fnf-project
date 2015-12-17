json.array!(@administration_trademarks) do |administration_trademark|
  json.extract! administration_trademark, :id, :name, :description, :user_id, :company, :company_id
  json.url administration_trademark_url(administration_trademark, format: :json)
end
