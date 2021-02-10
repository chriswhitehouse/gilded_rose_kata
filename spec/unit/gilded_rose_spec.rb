# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  let(:items) { [
                  Item.new("apple", 1, 3),
                  Item.new("banana", 2, 4),
                  Item.new("Aged Brie", 1, 5),
                  Item.new("Sulfuras, Hand of Ragnaros", 1, 80),
                  Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 5),
                ] }

  let(:inventory) { GildedRose.new(items) }

  describe '#update_quality' do
    it 'does not change the name' do
      inventory.update_quality
      expect(items[0].name).to eq 'apple'
    end

    it 'does change the sell_in for all items except Sulfuras' do
      expect{ inventory.update_quality }.to change { items[0].sell_in }.by(-1)
    end

    it 'Once the sell by date has passed, Quality degrades twice as fast' do
      expect { inventory.update_quality }.to change { items[0].quality }.by(-1)
      expect { inventory.update_quality }.to change { items[0].quality }.by(-2)
    end

    it 'The Quality of an item is never negative' do
      inventory.update_quality
      inventory.update_quality
      inventory.update_quality
      expect(items[0].quality).not_to be <0
    end

    it "'Aged Brie' actually increases in Quality the older it gets" do
      expect { inventory.update_quality }.to change { items[2].quality }.by(1)
      expect { inventory.update_quality }.to change { items[2].quality }.by(2)
    end

    it 'The Quality of an item is never more than 50' do
      50.times { inventory.update_quality }
      expect(items[2].quality).not_to be >50
    end

    it '"Sulfuras", being a legendary item, never has to be sold or decreases in Quality' do
      expect { inventory.update_quality }.not_to change { items[3].sell_in }
      expect { inventory.update_quality }.not_to change { items[3].quality }
    end

    it '"Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
    Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
    Quality drops to 0 after the concert' do
      expect { inventory.update_quality }.to change { items[4].quality }.by(1)
      expect { inventory.update_quality }.to change { items[4].quality }.by(2)
      4.times { inventory.update_quality }
      expect { inventory.update_quality }.to change { items[4].quality }.by(3)
      5.times { inventory.update_quality }
      expect(items[4].quality).to eq 0
    end
  end
end
