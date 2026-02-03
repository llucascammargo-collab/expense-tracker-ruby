require 'json'
require_relative 'expense'

class ExpenseManager
    FILE_PATH = 'expenses.json'

    def initialize
        @expenses = load_expenses
    end

    def add_expense(description, amount, category, date, payment_method)
        expense = Expense.new(description, amount, category, date, payment_method)
        @expenses << expense
        save_expenses
    end

   def list_expenses
    if @expenses.empty?
      puts "No expenses recorded."
    else
      @expenses.each_with_index do |expense, index|
            puts "#{index + 1}. #{expense.description} - Category: #{expense.category} - Amount: $#{expense.amount} - Date: #{expense.date} - Payment Method: #{expense.payment_method}"
          end
       end
    end

    def show_total
        total = @expenses.sum { |expense| expense.amount }
        puts "Total Expenses: $#{total}"
    end

    def show_average
        if @expenses.empty?
            puts "No expenses to calculate average."
        else
            average = @expenses.sum { |expense| expense.amount } / @expenses.length
            puts "Average Expense: $#{average}"
        end
    end
    
    def show_category_totals
    if @expenses.empty?
      puts "No expenses recorded."
      return
    end

    category_totals = Hash.new(0)
    @expenses.each do |expense|
      category_totals[expense.category] += expense.amount
    end

    puts "Category Totals:"
    category_totals.each do |category, total|
      puts "#{category}: $#{total}"
    end
  end

  def remove_expense(index)
      if index >= 0 && index < @expenses.length
          @expenses.delete_at(index)
            save_expenses
            puts "Expense removed successfully."
      else
            puts "Invalid expense index."
        end
    end

def edit_expense(index, new_description:, new_amount:, new_category:, new_date:, new_payment_method:)
  if index >= 0 && index < @expenses.length
    expense = @expenses[index]

    expense.description = new_description
    expense.amount = new_amount
    expense.category = new_category 
    expense.date = new_date
    expense.payment_method = new_payment_method

    save_expenses
    puts "Expense updated successfully."
  else
    puts "Invalid expense index."
  end
end

def payment_method(index, new_payment_method:)
  if index >= 0 && index < @expenses.length
    expense = @expenses[index]
    expense.payment_method = new_payment_method
    save_expenses
    puts "Payment method updated successfully."
  else
    puts "Invalid expense index."
  end
end

def show_payment_method_totals
    return puts "No expenses recorded." if @expenses.empty?

    totals = Hash.new(0)
    @expenses.each do |expense|
      method = expense.payment_method || "Unknown"
      totals[method] += expense.amount
    end

    puts "\nPayment Method Totals:"
    totals.each do |method, total|  
      puts "#{method}: $#{total.round(2)}"
    end
  end

  def show_biggest_expense
    return puts "No expenses recorded." if @expenses.empty?

    biggest = @expenses.max_by { |e| e.amount }
    puts "\nBiggest Expense:"
    puts "#{biggest.description} - Amount: $#{biggest.amount} - Category: #{biggest.category} - Date: #{biggest.date} - Payment Method: #{biggest.payment_method}"
  end

  def show_monthly_totals
    return puts "No expenses recorded." if @expenses.empty?
    monthly = Hash.new(0)
    @expenses.each do |expense|
      month = expense.date[0..6] # Assuming date is in 'YYYY-MM-DD' format
      monthly[month] += expense.amount
    end

    puts "\nMonthly Totals:"
    monthly.each do |month, total|      
      puts "#{month}: $#{total.round(2)}" 
    end
  end

  private

  def save_expenses
    data = @expenses.map do |expense|
      { description: expense.description, amount: expense.amount, category: expense.category, date: expense.date, payment_method: expense.payment_method }
    end

    File.write(FILE_PATH, JSON.pretty_generate(data))
  end

  def load_expenses
    if File.exist?(FILE_PATH)
      JSON.parse(File.read(FILE_PATH), symbolize_names: true).map do |data|
        Expense.new(data[:description], data[:amount], data[:category], data[:date], data[:payment_method])
      end
    else
      []
    end
  end
end