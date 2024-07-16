# frozen_string_literal: true
require './price_calculator.rb'
require './order.rb'

class CreateOrderThroughCLI

  def initialize
    @order = Order.new
  end

  def call
    @order.table_number = ask_user_for_table_number
    @order.names = ask_user_for_names
    @order.items = ask_user_for_items
    @order.generate_price_list(@order)
    @order.generate_total(@order)
    @order.calculate_tax(@order)
    @order
  end

  private

  def ask_user_for_table_number
    puts 'Please enter your table number'
    number = gets.chomp.to_i
    number < 10 ? number : raise('invalid number!')
  end

  def ask_user_for_names
    puts 'Who is at the table?'
    list_of_names = gets.chomp
    list_of_names.split(', ')
  end

  def ask_user_for_items
    customer_items = []
    # understand why do |_, index| shows 0 as index in first loop, but |index| shows nil as the index for the first loop
    loop.with_index do |_, index|
      if index.zero?
        puts 'Would you like to order an item?'
      else
        puts 'Would you like to order another item?'
      end
      break unless gets.chomp.downcase == 'yes'

      puts 'Please enter your item'
      item = gets.chomp
      unless @order.valid_item?(item)
        puts 'item not valid'
        next
      end
      puts 'Please enter the amount'
      number = gets.chomp
      customer_items << { "item": item, "number": number }
    end
    customer_items
  end

end


