# frozen_string_literal: true

require 'item'

describe Item do
  let(:item) { Item.new('apple', 1, 3) }
  describe '#to_s' do
    it 'should covert properties to a string' do
      expect(item.to_s).to eq 'apple, 1, 3'
    end
  end
end
