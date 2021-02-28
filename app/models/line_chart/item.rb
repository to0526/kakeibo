module LineChart
  class Item
    attr_reader :label, :user_ids, :payment_classification_ids, :payment_method_ids

    def initialize(label:, user_ids:, payment_classification_ids:, payment_method_ids:)
      @label = label
      @user_ids = user_ids
      @payment_classification_ids = payment_classification_ids
      @payment_method_ids = payment_method_ids
    end

    def to_json
      {
        label: label,
        border_color: border_color,
        data: data,
        fill: false
      }
    end

    private

    def border_color
      case date.month
      when  1 then "#E60012"
      when  2 then "#E39800"
      when  3 then "#FFF100"
      when  4 then "#8FC31F"
      when  5 then "#009944"
      when  6 then "#009E96"
      when  7 then "#00A0E9"
      when  8 then "#0068B7"
      when  9 then "#1D2088"
      when 10 then "#920783"
      when 11 then "#E4007F"
      when 12 then "#E5004F"
      end
    end

    def data
      total_amount_until_date = 0
      args = {
        payed_on: dates,
        user_id: user_ids,
        payment_classification_id: payment_classification_ids,
        payment_method_id: payment_method_ids,
      }
      amount_with_date = ::Item.where(args).group(:payed_on).sum(:amount)
      dates.map do |date|   
        amount = amount_with_date[date] || 0
        total_amount_until_date += amount
        total_amount_until_date
      end                   
    end                     
                            
    def date                
      Time.zone.parse(label).to_date
    end

    def dates
      (date.beginning_of_month..date.end_of_month).to_a
    end
  end
end
