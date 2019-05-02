# frozen_string_literal: true

require './lib/rule_type_validator'

RSpec.describe RuleTypeValidator do
  context 'With valid type' do
    subject { described_class.new('SameItemRule') }

    describe '#valid?' do
      it 'returns true' do
        expect(subject.valid?).to be true
      end
    end
  end

  context 'With invalid type' do
    subject { described_class.new('Item') }

    describe '#valid?' do
      it 'returns false' do
        expect(subject.valid?).to be false
      end
    end
  end
end
