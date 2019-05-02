# frozen_string_literal: true

require './lib/checkout'

RSpec.describe Checkout do
  PROMOTIONAL_RULES = [{ type: 'SameItemRule', rule: { product_code: '001', min_quantity: 2, new_price: 8.50 } },
                       { type: 'TotalPriceLimitRule', rule: { limit: 60, discount_percentage: 10 } }].freeze

  subject { described_class.new(PROMOTIONAL_RULES) }

  let(:item_1) { { product_code: '001', name: 'Lavender heart', price: 9.25 } }
  let(:item_2) { { product_code: '002', name: 'Personalised cufflinks', price: 45.00 } }
  let(:item_3) { { product_code: '003', name: 'Kids T-shirt', price: 19.95 } }

  describe '#scan' do
    it 'adds the item in the basket' do
      expect { subject.scan(item_1) }.to change { subject.items.count }.from(0).to(1)
    end
  end

  context 'Basket: 001,002,003' do
    describe '#total' do
      it 'returns the corrent total price' do
        subject.scan(item_1)
        subject.scan(item_2)
        subject.scan(item_3)
        expect(subject.total).to eq 66.78
      end
    end
  end

  context 'Basket: 001,003,001' do
    describe '#total' do
      it 'returns the corrent total price' do
        subject.scan(item_1)
        subject.scan(item_3)
        subject.scan(item_1)
        expect(subject.total).to eq 36.95
      end
    end
  end

  context 'Basket: 001,002,001,003' do
    describe '#total' do
      it 'returns the corrent total price' do
        subject.scan(item_1)
        subject.scan(item_2)
        subject.scan(item_1)
        subject.scan(item_3)
        expect(subject.total).to eq 73.76
      end
    end
  end
end
