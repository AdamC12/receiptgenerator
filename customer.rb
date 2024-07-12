# frozen_string_literal: true
class Customer

  def get_table_number
    obtain_table_number
  end

  def get_names
    obtain_names
  end

  def get_items
    obtain_items
  end

  private

  def obtain_names
    puts 'Who is at the table?'
    list_of_names = gets.chomp
    list_of_names.split(', ')
  end

  def obtain_items
    customer_items = Array.new
    items = item_information
    loop do
      puts 'Would you like to order an item?'
      break unless gets.chomp.downcase == 'yes'

      puts 'Please enter your item'
      item = gets.chomp
      if items[item].nil?
        puts 'item not valid'
        next
      end

      customer_items << item
    end

    build_price_list(customer_items.tally)

  end

  def item_information
    item_information = File.read('./hipstercoffee.json')
    JSON.parse(item_information)['prices'][0]
  end

  def build_price_list(customer_items)
    items = item_information
    price_array = Array.new
    customer_items.each do |k,v|
      price = items[k]
      price_array << { k => ["number": v, "price": price] }
    end
    items_with_total = build_total(price_array)
    format_customer_items(items_with_total)
  end

  def format_customer_items(price_array)
    formatted_items = Array.new
    price_array.each do |item|
      p item.keys[0]
      if item.keys[0] == 'Total'
        formatted_items << item
        break
      end
      str = "#{item.keys[0]}        #{item.values[0][0][:number]} x #{item.values[0][0][:price]}"
      formatted_items << str
    end
    formatted_items
  end

  def obtain_table_number
    puts 'Please enter your table number'
    number = gets.chomp.to_i
    number < 10 ? number : raise('invalid number!')
  end

  def build_total(items)
    total = 0
    items.each do |item|
      total += item.values[0][0][:price]
    end
    items << { 'Total' => total.sprintf('%.2f') }
  end
end
