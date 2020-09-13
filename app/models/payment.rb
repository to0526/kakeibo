class Payment < Item
  before_save :make_negative_amount, if: Proc.new { |payment| payment.amount > 0 }

  def self.name_with_amount(date:)
    monthly(date).group(:payment_classification_id).sum(:amount).each_with_object({}) do |(id, amount), hash|
      hash[PaymentClassification.find(id).name] = amount
    end
  end

  private

  def make_negative_amount
    self.amount = amount * -1
  end
end
