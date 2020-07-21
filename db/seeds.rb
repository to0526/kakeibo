unless User.exists?(email: "test1@example.com")
  User.create!(
    email: "test1@example.com",
    password: "password",
    password_confirmation: "password",
    name: "テスト１"
  )
end

unless User.exists?(email: "test2@example.com")
  User.create!(
    email: "test2@example.com",
    password: "password",
    password_confirmation: "password",
    name: "テスト２"
  )
end

PaymentClassification.find_or_create_by!(purpose: :required, name: "居住費")
PaymentClassification.find_or_create_by!(purpose: :required, name: "水道光熱費")
PaymentClassification.find_or_create_by!(purpose: :required, name: "通信費")
PaymentClassification.find_or_create_by!(purpose: :required, name: "食費")
PaymentClassification.find_or_create_by!(purpose: :required, name: "雑費・医療費")
PaymentClassification.find_or_create_by!(purpose: :required, name: "一般保険料")
PaymentClassification.find_or_create_by!(purpose: :enjoyment, name: "娯楽費")
PaymentClassification.find_or_create_by!(purpose: :enjoyment, name: "コンビニで買ったおやつ")
PaymentClassification.find_or_create_by!(purpose: :enjoyment, name: "本、雑誌")
PaymentClassification.find_or_create_by!(purpose: :enjoyment, name: "服")
PaymentClassification.find_or_create_by!(purpose: :enjoyment, name: "DVD")
PaymentClassification.find_or_create_by!(purpose: :enjoyment, name: "使途不明金")

PaymentMethod.find_or_create_by!(name: "現金")
PaymentMethod.find_or_create_by!(name: "ID")
PaymentMethod.find_or_create_by!(name: "クレジットカード(楽天)")
PaymentMethod.find_or_create_by!(name: "クレジットカード(SEIYU)")
PaymentMethod.find_or_create_by!(name: "クレジットカード(ヨドバシ)")
PaymentMethod.find_or_create_by!(name: "クレジットカード(VISA)")
