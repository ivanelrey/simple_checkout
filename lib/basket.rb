# frozen_string_literal: true

class Basket
  attr_reader :items, :promotions

  def initialize(items)
    @items = items
    @promotions = []
  end

  def add_promotion(promotion)
    promotions << promotion
  end

  def total_price
    (items.map { |h| h[:price] }.sum - promotions.sum).round(2)
  end

  def total_price_by_code(product_code)
    items.map { |item| item[:price] if item[:product_code] == product_code }.compact.sum
  end

  def item_count_by_code(product_code)
    items.select { |item| item[:product_code] == product_code }.count
  end
end
