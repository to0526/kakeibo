json.array! @items do |item|
  json.payed_on item.payed_on
  json.amount   item.amount
  json.user_id  item.user_id
  json.payment_classification_id item.payment_classification_id
  json.payment_method_id item.payment_method_id
  json.created_at item.created_at
  json.updated_at item.updated_at
  json.note item.note
  json.type item.type
end
