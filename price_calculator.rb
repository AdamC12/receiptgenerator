# frozen_string_literal: true
class PriceCalculator
  def call(order,item_information)
    price_list = build_price_list(order,item_information)
    total = price_list.pop['Total']
    tax = total * 0.0864
    [price_list, total, tax]
  end

  private

  def build_price_list(customer_items,item_information)
    price_array = Array.new
    customer_items[:items].each do |hash|
      price = item_information[hash[:item]]
      price_array << { hash[:item] => ["number": hash[:number].to_i, "price": price] }
    end
    items_with_total = build_total(price_array)
    format_customer_items(items_with_total)
  end

  def build_total(items)
    total = 0
    items.each do |item|
      total += (item.values[0][0][:price] * item.values[0][0][:number])
    end
    items << { 'Total' => total }
  end

  def format_customer_items(items_with_total)
    formatted_items = Array.new
    items_with_total.each do |item|
      if item.keys[0] == 'Total'
        formatted_items << item
        break
      end
      str = "#{item.keys[0]}        #{item.values[0][0][:number]} x #{item.values[0][0][:price]}"
      formatted_items << str
    end
    formatted_items
  end
end