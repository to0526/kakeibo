module LineChart
  class Table
    attr_reader :label, :user_ids

    def initialize(label:, user_ids:)
      @label = label
      @user_ids = user_ids
    end

    def to_json
      {
        year_month: label,
        income: income.to_s(:delimited),
        payment: payment.to_s(:delimited),
        total: total.to_s(:delimited)
      }
    end

    def income
      @income ||= ::Income.where(payed_on: dates, user_id: user_ids).sum(:amount)
    end

    def payment
      @payment ||= ::Payment.where(payed_on: dates, user_id: user_ids).sum(:amount)
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
