json.extract! reservation, :id, :day, :kind, :amount, :user_id, :payment_classification_id, :payment_method_id, :note, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
