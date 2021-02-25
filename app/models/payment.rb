class Payment < Item
  before_save :make_negative_amount, if: Proc.new { |payment| payment.amount > 0 }

  private

  def make_negative_amount
    self.amount = amount * -1
  end
end
