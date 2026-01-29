Expense Tracker (Ruby OOP)
A command-line financial expense tracker built with Ruby, designed to practice Object-Oriented Programming (OOP), code organization, and data persistence.
This project started as a simple procedural script and evolved into a modular system following real software development principles.

Features

Add new expenses
List all recorded expenses
Remove expenses
Category-based expense totals
Average expense calculation
Persistent data storage using JSON
Structured with Object-Oriented Programming

Project Architecture

The system is organized into separate layers, just like real-world applications:
File	Responsibility
main.rb	CLI interface (handles user input and menu)
expense.rb	Expense model (represents a single expense object)
expense_manager.rb	Business logic and system control (manages expenses, calculations, and storage)
This separation improves:
Code readability
Maintainability
Scalability
Professional structure

Data Persistence

Expenses are saved locally in a JSON file so data is not lost between program runs.
The data file is excluded from version control using .gitignore, following best practices for separating code from user data.

Technologies Used
Ruby
JSON
Object-Oriented Programming
Command-Line Interface (CLI)
Git & GitHub for version control

Learning Objectives

This project was built to strengthen understanding of:
Classes and Objects
Encapsulation
Separation of responsibilities
File handling in Ruby
JSON data storage
Refactoring from procedural code to OOP

How to Run

Make sure Ruby is installed, then run:
ruby main.rb

Planned Improvements

This project is evolving toward a full financial management system. Upcoming features include:
Editing expenses
Filtering by date (week, month, year)
Budgets and spending limits
Credit card tracking
Reports and analytics
Migration to Ruby on Rails for a web version

Lucas Camargo

Developed as part of a learning journey toward becoming a professional developer, focusing on building real, structured systems instead of isolated scripts.

