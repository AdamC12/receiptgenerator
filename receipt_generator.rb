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
    # table_number = get_table_number
    # names = get_customer_names
    price_list = get_customer_price_list
    # timestamp = generate_timestamp
    # puts "\n\n\n\n\n\n\n#{timestamp}"
    # shopinformation = get_shop_information
    # puts shopinformation['shopName']
    # puts
    # puts shopinformation['address']
    # puts shopinformation['phone']
    # puts
    # puts 'Voucher 10% Off All Muffins!'
    # puts "Valid #{Date.today.strftime('%d-%m-%Y')} to #{(Date.today+183).strftime('%d-%m-%Y')}"
    # puts "Table: #{table_number} / [10]"
    # puts names.join(',')
    binding.pry
    # price_list.each do |item|
    #   puts item
    # end
    # puts 'Thank you!'
  end

  private

  def generate_timestamp
    Time.now.strftime('%Y.%m.%d %H:%M:%S')
  end

  def get_shop_information
    shop_information = File.read('./hipstercoffee.json')
    JSON.parse(shop_information)
  end

  def get_customer_price_list
    @customer.get_items
  end

  def get_customer_names
    @customer.get_names
  end

  def get_table_number
    @customer.get_table_number
  end
end

# irb -r ./receipt_generator.rb
# ruby receipt_generator.rb

