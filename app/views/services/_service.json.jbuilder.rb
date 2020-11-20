json.extract! service, :id, :name, :description, :kind, :phone_number, :url, :picture, :created_at, :updated_at
json.url customer_url(service, format: :json)