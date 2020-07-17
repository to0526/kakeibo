json.extract! payment, :id, :payed_on, :amount, :user_id, :payment_classification_id, :payment_method_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
