# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end
  end
end

describe Item do
  let(:item) { Item.new("apple", 1, 3) }
  describe '#to_s' do
    it 'should covert properties to a string' do
      expect(item.to_s).to eq 'apple, 1, 3'
    end
  end
end
