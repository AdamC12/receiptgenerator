# frozen_string_literal: true

require 'pry'
require 'json'
require 'date'
require './customer.rb'

class ReceiptGenerator
  def initialize
    @customer = Customer.new
  end

  def print_receipt
    get_customer_information
    timestamp = generate_timestamp
    puts "\n\n\n\n\n\n\n#{timestamp}"
    shopinformation = get_shop_information
    puts shopinformation['shopName']
    puts
    puts shopinformation['address']
    puts shopinformation['phone']
    puts
    puts 'Voucher 10% Off All Muffins!'
    puts "Valid #{Date.today.strftime('%d-%m-%Y')} to #{(Date.today+183).strftime('%d-%m-%Y')}"
    puts "Table: #{@table_number} / [10]"
    puts @names.join(',')
    @items.each do |item|
      puts item
    end
    puts "Total:         #{@total.round(2)}"
    puts "Tax:           #{@tax.round(2)}"
    puts 'Thank you!'
  end

  private

  def generate_timestamp
    Time.now.strftime('%Y.%m.%d %H:%M:%S')
  end

  def get_shop_information
    shop_information = File.read('./hipstercoffee.json')
    JSON.parse(shop_information)
  end

  def get_customer_information
    @table_number = @customer.get_table_number
    @names = @customer.get_names
    @items = @customer.get_items
    @total = @items.pop['Total']
    @tax = @total * 0.0864
  end
end

# irb -r ./receipt_generator.rb
# ruby receipt_generator.rb

