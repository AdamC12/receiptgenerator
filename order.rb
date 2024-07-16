# frozen_string_literal: true

class Order
  attr_accessor :tax, :total, :price_list, :table_number, :names, :items, :formatted_price_list

  def initalize(price_calculator: PriceCalculator.new)
    @price_calculator = price_calculator
  end

  def generate_price_list(order)
    @price_list = @price_calculator.generate_price_list(order, item_information)
  end

  def generate_total(order)
    @total = @price_calculator.generate_total(order)
  end

  def calculate_tax(order)
    @tax = @price_calculator.generate_tax(order)
  end

  def valid_item?(item)
    !item_information[item].nil?
  end

  private

  def item_information
    @item_information ||= JSON.parse(File.read('./hipstercoffee.json'))['prices'][0]
  end

end
