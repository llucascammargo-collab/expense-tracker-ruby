expenses = []

def add_expense(expenses)
    loop do
    puts "Enter Expense Description:"
    description = gets.chomp
    puts "Enter Expense Amount:"
    amount = gets.chomp.to_f
    puts "What is the category of the expense?"
    category = gets.chomp
    expenses << { description: description, amount: amount, category: category }
    puts "Expense added successfully!"
    puts "Do you want to add another expense? (y/n)"
    choice = gets.chomp.downcase    
    break if choice != 'y'  
    end
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
    total = 0
    expenses.each do |expense|
        total += expense[:amount]
    end
    puts "Total Expenses: $#{total}"
end

def show_average(expenses)
    if expenses.empty?
        puts "No expenses recorded to calculate average."
    else 
        total = 0
        expenses.each do |expense|
            total += expense[:amount]
        end
        average = total / expenses.length
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
    when "1"
        add_expense(expenses)
    when "2"
        list_expenses(expenses)
    when "3"
        show_total(expenses)
    when "4"
        show_average(expenses)
    when "5"
        show_category_totals(expenses)
    when "6"
        puts "Exiting the Expense Tracker. Goodbye!"
        break
    else
        puts "Invalid option. Please try again."
    end
end