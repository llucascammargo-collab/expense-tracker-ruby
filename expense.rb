class Expense
    attr_accessor :description, :amount, :category, :date, :payment_method

    def initialize(description, amount, category, date, payment_method)
        @description = description
        @amount = amount
        @category = category
        @date = date
        @payment_method = payment_method
    end
end