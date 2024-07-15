# frozen_string_literal: true
class CreateOrderThroughCLI
  def call(item_information)
    build_order(item_information)
  end

  private

  def build_order(item_information)
    order = []
    order << {"table": table_number, "names": names, "items": items(item_information)}
  end

  def table_number
    puts 'Please enter your table number'
    number = gets.chomp.to_i
    number < 10 ? number : raise('invalid number!')
  end

  def names
    puts 'Who is at the table?'
    list_of_names = gets.chomp
    list_of_names.split(', ')
  end

  def items(item_information)
    customer_items = Array.new
    items = item_information
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
      if items[item].nil?
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