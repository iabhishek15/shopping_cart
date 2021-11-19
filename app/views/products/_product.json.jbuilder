json.extract! product, :id, :name, :processor, :operating_system, :memory, :storage, :display, :price, :created_at, :updated_at
json.url product_url(product, format: :json)
