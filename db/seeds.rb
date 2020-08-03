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

PaymentClassification.find_or_create_by!(purpose: :required, name: "食費", sort: 1)
PaymentClassification.find_or_create_by!(purpose: :required, name: "居住費", sort: 2)
PaymentClassification.find_or_create_by!(purpose: :required, name: "水道光熱費", sort: 3)
PaymentClassification.find_or_create_by!(purpose: :required, name: "通信費", sort: 4)
PaymentClassification.find_or_create_by!(purpose: :required, name: "雑費・医療費", sort: 5)
PaymentClassification.find_or_create_by!(purpose: :required, name: "一般保険料", sort: 6)
PaymentClassification.find_or_create_by!(purpose: :enjoyment, name: "娯楽費", sort: 7)
PaymentClassification.find_or_create_by!(purpose: :enjoyment, name: "コンビニで買ったおやつ", sort: 8)
PaymentClassification.find_or_create_by!(purpose: :enjoyment, name: "本、雑誌", sort: 9)
PaymentClassification.find_or_create_by!(purpose: :enjoyment, name: "服", sort: 10)
PaymentClassification.find_or_create_by!(purpose: :enjoyment, name: "DVD", sort: 11)
PaymentClassification.find_or_create_by!(purpose: :enjoyment, name: "使途不明金", sort: 12)

PaymentMethod.find_or_create_by!(name: "現金")
PaymentMethod.find_or_create_by!(name: "ID")
PaymentMethod.find_or_create_by!(name: "クレジットカード(楽天)")
PaymentMethod.find_or_create_by!(name: "クレジットカード(SEIYU)")
PaymentMethod.find_or_create_by!(name: "クレジットカード(ヨドバシ)")
PaymentMethod.find_or_create_by!(name: "クレジットカード(VISA)")
