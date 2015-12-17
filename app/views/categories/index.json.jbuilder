json.array!(@categories) do |category|
  json.extract! category, :id, :user_id, :name, :description, :displayed
  json.url category_url(category, format: :json)
end
