# frozen_string_literal: true

require 'pry'
require 'json'
require 'date'
require './create_order_through_cli.rb'


class ReceiptGenerator
  def initialize
    # @customer = Customer.new
    @order = CreateOrderThroughCLI.new.call
  end

  def print_receipt
    timestamp = generate_timestamp
    puts "\n\n\n\n\n\n\n#{timestamp}"
    puts shop_information['shopName']
    puts
    puts shop_information['address']
    puts shop_information['phone']
    puts
    puts 'Voucher 10% Off All Muffins!'
    puts "Valid #{Date.today.strftime('%d-%m-%Y')} to #{(Date.today+183).strftime('%d-%m-%Y')}"
    puts "Table: #{@order.table_number} / [10]"
    puts @order.names.join(',')
    formatted_price_list.each do |item|
      puts item
    end
    puts "Total:         #{@order.total.round(2)}"
    puts "Tax:           #{@order.tax.round(2)}"
    puts 'Thank you!'
  end

  private

  def generate_timestamp
    Time.now.strftime('%Y.%m.%d %H:%M:%S')
  end

  def shop_information
    @shop_information ||= JSON.parse(File.read('./hipstercoffee.json'))
  end

  def format_price_list
    formatted_items = Array.new
    @order.price_list.each do |item|
      str = "#{item.keys[0]}        #{item.values[0][0][:number]} x #{item.values[0][0][:price]}"
      formatted_items << str
    end
    formatted_items
  end

end

# irb -r ./receipt_generator.rb
# ruby receipt_generator.rb
