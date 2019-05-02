# frozen_string_literal: true

class RuleTypeValidator
  attr_reader :type

  VALID_TYPES = %w[SameItemRule TotalPriceLimitRule].freeze

  def initialize(type)
    @type = type
  end

  def valid?
    VALID_TYPES.include?(type)
  end
end
