require 'json'
require_relative 'expense'

class ExpenseManager
    FILE_PATH = 'expenses.json'

    def initialize
        @expenses = load_expenses
    end

    def add_expense(description, amount, category, date)
        expense = Expense.new(description, amount, category, date)
        @expenses << expense
        save_expenses
    end

   def list_expenses
    if @expenses.empty?
      puts "No expenses recorded."
    else
      @expenses.each_with_index do |expense, index|
            puts "#{index + 1}. #{expense.description} - Category: #{expense.category} - Amount: $#{expense.amount} - Date: #{expense.date}"
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

def edit_expense(index, new_description:, new_amount:, new_category:, new_date:)
  if index >= 0 && index < @expenses.length
    expense = @expenses[index]

    expense.description = new_description
    expense.amount = new_amount
    expense.category = new_category 
    expense.date = new_date

    save_expenses
    puts "Expense updated successfully."
  else
    puts "Invalid expense index."
  end
end

  private

  def save_expenses
    data = @expenses.map do |expense|
      { description: expense.description, amount: expense.amount, category: expense.category, date: expense.date }
    end

    File.write(FILE_PATH, JSON.pretty_generate(data))
  end

  def load_expenses
    if File.exist?(FILE_PATH)
      JSON.parse(File.read(FILE_PATH), symbolize_names: true).map do |data|
        Expense.new(data[:description], data[:amount], data[:category], data[:date])
      end
    else
      []
    end
  end
end