# frozen_string_literal: true

class TotalPriceLimitRule
  attr_reader :limit, :discount_percentage, :basket

  def initialize(rule, basket)
    @limit = rule[:limit]
    @discount_percentage = rule[:discount_percentage]
    @basket = basket
  end

  def promotion
    return 0 unless applicable

    basket.total_price * discount_percentage / 100.0
  end

  private

  def applicable
    basket.total_price > limit
  end
end
