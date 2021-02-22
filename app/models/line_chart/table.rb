module LineChart
  class Table
    attr_reader :label

    def initialize(label:)
      @label = label
    end

    def to_json
      {
        income: income,
        payment: payment,
        total: total
      }
    end

    def income
      @income ||= ::Income.where(payed_on: dates).sum(:amount)
    end

    def payment
      @payment ||= ::Payment.where(payed_on: dates).sum(:amount)
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
