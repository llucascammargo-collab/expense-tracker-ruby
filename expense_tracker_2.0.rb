require 'json'
FILE_PATH = 'expenses.json'

def get_valid_description
  description = ""
  while description.strip.empty?
    puts "Enter expense description:"
    description = gets.chomp

    if description.strip.empty?
      puts "Description cannot be empty. Please try again."
    end
  end
  description
end

def get_valid_amount
  amount = 0
  while amount <= 0
    puts "Enter expense amount:"
    amount = gets.chomp.to_f

    if amount <= 0
      puts "Amount must be greater than zero."
    end
  end
  amount
end

def get_valid_category
  category = ""
  while category.strip.empty?
    puts "Enter expense category:"
    category = gets.chomp

    if category.strip.empty?
      puts "Category cannot be empty. Please try again."
    end
  end
  category
end

def add_expense(expenses)
  description = get_valid_description
  amount = get_valid_amount
  category = get_valid_category

  expense = { description: description, amount: amount, category: category }
  expenses << expense
  save_expenses(expenses)

  puts "Expense added successfully!"
end

def list_expenses(expenses)
  if expenses.empty?
    puts "No expenses recorded."
  else
    puts "List of Expenses:"
    expenses.each_with_index do |expense, index|
      puts "Expense #{index + 1}: #{expense[:description]} - Category: #{expense[:category]} - Amount: $#{expense[:amount]}"
    end
  end
end

def show_total(expenses)
  total = expenses.sum { |expense| expense[:amount] }
  puts "Total Expenses: $#{total}"
end

def show_average(expenses)
  if expenses.empty?
    puts "No expenses recorded to calculate average."
  else
    average = expenses.sum { |expense| expense[:amount] } / expenses.length
    puts "Average Expense: $#{average}"
  end
end

def show_category_totals(expenses)
  if expenses.empty?
    puts "No expenses recorded."
    return
  end

  category_totals = Hash.new(0)
  expenses.each do |expense|
    category_totals[expense[:category]] += expense[:amount]
  end

  puts "Category Totals:"
  category_totals.each do |category, total|
    puts "#{category}: $#{total}"
  end
end

def save_expenses(expenses)
  File.write(FILE_PATH, JSON.pretty_generate(expenses))
end

def load_expenses
  if File.exist?(FILE_PATH)
    JSON.parse(File.read(FILE_PATH), symbolize_names: true)
  else
    []
  end
end

expenses = load_expenses

loop do
  puts "\nFinancial Expense Tracker"
  puts "Choose an option:"
  puts "1 - Add Expense"
  puts "2 - List Expenses"
  puts "3 - Show Total"
  puts "4 - Show Average"
  puts "5 - Show Category totals"
  puts "6 - Exit"

  option = gets.chomp

  case option
  when "1" then add_expense(expenses)
  when "2" then list_expenses(expenses)
  when "3" then show_total(expenses)
  when "4" then show_average(expenses)
  when "5" then show_category_totals(expenses)
  when "6"
    puts "Exiting the Expense Tracker. Goodbye!"
    break
  else
    puts "Invalid option. Please try again."
  end
end
