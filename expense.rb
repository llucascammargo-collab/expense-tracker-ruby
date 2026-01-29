class Expense
    attr_accessor :description, :amount, :category, :date

    def initialize(description, amount, category, date)
        @description = description
        @amount = amount
        @category = category
        @date = date
    end
end