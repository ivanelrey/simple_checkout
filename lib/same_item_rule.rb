# frozen_string_literal: true

class SameItemRule
  attr_reader :min_quantity, :product_code, :new_price, :basket

  def initialize(rule, basket)
    @min_quantity = rule[:min_quantity]
    @product_code = rule[:product_code]
    @new_price = rule[:new_price]
    @basket = basket
  end

  def promotion
    return 0 unless applicable

    basket.total_price_by_code(product_code) - basket.item_count_by_code(product_code) * new_price
  end

  private

  def applicable
    basket.item_count_by_code(product_code) >= min_quantity
  end
end
