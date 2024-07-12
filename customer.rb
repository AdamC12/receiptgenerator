# frozen_string_literal: true
class Customer

  def initialize
    @items = item_information
  end

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
    #understand why do |_, index| shows 0 as index in first loop, but |index| shows nil as the index for the first loop
    loop.with_index do |_,index|
      if index.zero?
        puts 'Would you like to order an item?'
      else
        puts 'Would you like to order another item?'
      end
      break unless gets.chomp.downcase == 'yes'

      puts 'Please enter your item'
      item = gets.chomp
      if items[item].nil?
        puts 'item not valid'
        next
      end
      puts 'Please enter the amount'
      number = gets.chomp
      customer_items << {"item":item, "number": number}
    end
    build_price_list(customer_items)
  end

  def item_information
    item_information = File.read('./hipstercoffee.json')
    JSON.parse(item_information)['prices'][0]
  end

  def build_price_list(customer_items)
    price_array = Array.new
    customer_items.each do |hash|
      price = @items[hash[:item]]
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

  def obtain_table_number
    puts 'Please enter your table number'
    number = gets.chomp.to_i
    number < 10 ? number : raise('invalid number!')
  end

end
