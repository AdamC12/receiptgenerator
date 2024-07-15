# frozen_string_literal: true

require 'pry'
require 'json'
require 'date'
require './create_order_through_cli.rb'
require './price_calculator.rb'


class ReceiptGenerator
  def initialize
    # @customer = Customer.new
    item_information
    shop_information
    @order = CreateOrderThroughCLI.new.call(@item_information)[0]
    @price_list, @total, @tax = PriceCalculator.new.call(@order,@item_information)
  end

  def print_receipt
    timestamp = generate_timestamp
    puts "\n\n\n\n\n\n\n#{timestamp}"
    puts @shop_information['shopName']
    puts
    puts @shop_information['address']
    puts @shop_information['phone']
    puts
    puts 'Voucher 10% Off All Muffins!'
    puts "Valid #{Date.today.strftime('%d-%m-%Y')} to #{(Date.today+183).strftime('%d-%m-%Y')}"
    puts "Table: #{@order[:table]} / [10]"
    puts @order[:names].join(',')
    @price_list.each do |item|
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

  def shop_information
    @shop_information ||= JSON.parse(File.read('./hipstercoffee.json'))
  end

  def item_information
    @item_information ||= JSON.parse(File.read('./hipstercoffee.json'))['prices'][0]
  end
end

# irb -r ./receipt_generator.rb
# ruby receipt_generator.rb
