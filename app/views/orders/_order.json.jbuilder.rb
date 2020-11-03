json.extract! order, :id, :description, :customer_id, :service_id, :created_at, :updated_at
json.url order_url(order, format: :json)