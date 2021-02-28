module LineChart
  class Table
    attr_reader :label, :user_ids, :payment_classification_ids, :payment_method_ids

    def initialize(label:, user_ids:, payment_classification_ids:, payment_method_ids:)
      @label = label
      @user_ids = user_ids
      @payment_classification_ids = payment_classification_ids
      @payment_method_ids = payment_method_ids
    end

    def to_json
      {
        year_month: label,
        income: income.to_s(:delimited),
        payment: payment.to_s(:delimited),
        total: total.to_s(:delimited)
      }
    end

    private

    def income
      @income ||= ::Income.where(args).sum(:amount)
    end

    def payment
      @payment ||= ::Payment.where(args).sum(:amount)
    end

    def args
      {
        payed_on: dates,
        user_id: user_ids,
        payment_classification_id: payment_classification_ids,
        payment_method_id: payment_method_ids,
      }
    end

    def total
      income + payment
    end

    def date
      Time.zone.parse(label).to_date
    end

    def dates
      (date.beginning_of_month..date.end_of_month).to_a
    end
  end
end
