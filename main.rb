require_relative 'expense_manager'

def get_valid_description
  description = ""
  while description.strip.empty?
    puts "Enter expense description:"
    description = gets.chomp
    puts "Description cannot be empty." if description.strip.empty?
  end
  description
end

def get_valid_amount
  amount = 0
  while amount <= 0
    puts "Enter expense amount:"
    amount = gets.chomp.to_f
    puts "Amount must be greater than zero." if amount <= 0
  end
  amount
end

def get_valid_date
    puts "Enter date (YYYY-MM-DD):"
    gets.chomp
end

CATEGORIES = ["Food", "Transport", "Health", "Utilities", "Entertainment", "Bills", "Housing","Other"]
def get_valid_category
  loop do
    puts "Choose a category:"
    CATEGORIES.each_with_index do |cat, index|
      puts "#{index + 1} - #{cat}"
    end

    puts "#{CATEGORIES.length + 1} - Add new category"

    option = gets.chomp.to_i
    if option.between?(1, CATEGORIES.length)
      return CATEGORIES[option - 1]
    end

    if option == CATEGORIES.length + 1
      puts "Enter new category name:"
      new_category = gets.chomp.strip.capitalize
      if new_category.empty?
        puts "Category name cannot be empty."
      else
        CATEGORIES << new_category
        return new_category
      end
    else
      puts "Invalid option. Please try again."
    end
  end 
end

PAYMENT = ["Cash", "Credit Card", "Debit Card","Pix"]
def get_valid_payment_method
  loop do
    puts "Choose a payment method:"
    PAYMENT.each_with_index do |method, index|
      puts "#{index + 1} - #{method}"
    end

    option = gets.chomp.to_i
    if option.between?(1, PAYMENT.length)
      return PAYMENT[option - 1]
    else
      puts "Invalid payment method. Please try again."
    end
  end
end

manager = ExpenseManager.new

loop do
  puts "\nFinancial Expense Tracker"
  puts "Choose an option:"
  puts "1 - Add Expense"
  puts "2 - List Expenses"
  puts "3 - Show Total"
  puts "4 - Show Average"
  puts "5 - Show Category totals"
  puts "6 - Remove Expense"
  puts "7 - Edit Expense" 
  puts "8 - Exit"


  option = gets.chomp

  case option
  when "1"
    description = get_valid_description
    amount = get_valid_amount
    category = get_valid_category
    date = get_valid_date
    payment_method = get_valid_payment_method
    manager.add_expense(description, amount, category, date, payment_method)
    puts "Expense added successfully!"

  when "2"
    manager.list_expenses

  when "3"
    manager.show_total

  when "4"
    manager.show_average

  when "5"
    manager.show_category_totals(payment_method: payment_method)

  when "6"    
    manager.list_expenses
    puts "Enter the number of the expense to remove:"
    index = gets.chomp.to_i - 1
    manager.remove_expense(index)

  when "7"
    manager.list_expenses
    puts "Enter the number of the expense to edit:"
    index = gets.chomp.to_i - 1

    puts "Enter new description:"
    description = gets.chomp

    amount = get_valid_amount
    category = get_valid_category
    date = get_valid_date
    payment_method = get_valid_payment_method

    manager.edit_expense(index, new_description: description, new_amount: amount, new_category: category, new_date: date, new_payment_method: payment_method)
        
  when "8"
    puts "Exiting the Expense Tracker. Goodbye!"
    break

  else
    puts "Invalid option. Please try again."
  end
end
