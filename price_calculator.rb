# frozen_string_literal: true

class PriceCalculator

  def generate_price_list(order, item_information)
    price_array = Array.new
    order.items.each do |hash|
      price = item_information[hash[:item]]
      price_array << { hash[:item] => ["number": hash[:number].to_i, "price": price] }
    end
    price_array
  end

  def generate_tax(order)
    order.total * 0.0864
  end

  def generate_total(order)
    total = 0
    order.price_list.each do |item|
      total += (item.values[0][0][:price] * item.values[0][0][:number])
    end
    total
  end
  
end
