# frozen_string_literal: true

require 'basket'
require 'total_price_limit_rule'
require 'same_item_rule'
require 'rule_type_validator'

class Checkout
  attr_reader :items, :promotional_rules

  def initialize(promotional_rules = [])
    @items = []
    @promotional_rules = promotional_rules
  end

  def scan(item)
    items << item
  end

  def total
    basket = Basket.new(items)
    apply_promotions(basket)
    basket.total_price
  end

  private

  def apply_promotions(basket)
    promotional_rules.each do |rule|
      next unless RuleTypeValidator.new(rule[:type]).valid?

      klass = Object.const_get(rule[:type])
      basket.add_promotion(klass.new(rule[:rule], basket).promotion)
    end
  end
end
