require 'gilded_rose'

describe 'Feature Tests' do
  let(:items) { [
                  Item.new("apple", 1, 3),
                  Item.new("banana", 2, 4),
                  Item.new("Aged Brie", 1, 5),
                  Item.new("Sulfuras, Hand of Ragnaros", 1, 80),
                  Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 5),
                ] }

  let(:inventory) { GildedRose.new(items) }

  describe 'So that I can keep track of my stock' do
    it 'I want to maintain an inventory of items' do
      expect(items[0]).to be_a Item
      expect(items[1].name).to eq "banana"
    end
  end

  describe 'So that I know when I need to sell an item by' do
    it "I want each item to have a 'SellIn' property" do
      expect(items[0].sell_in).to eq 1
      expect(items[1].sell_in).to eq 2
    end
  end

  describe 'So that I know the value of an item when I sell it' do
    it "I want each item to have a 'Quality' property" do
      expect(items[0].quality).to eq 3
      expect(items[1].quality).to eq 4
    end
  end

  describe 'So that I can maintain a current view of quality and sellIn' do
    it "I want to be able to update quality of every item in the inventory at the end of each day" do
      expect { inventory.update_quality }.to change { items[0].quality }.by(-1)
      expect { inventory.update_quality }.to change { items[1].quality }.by(-1)
    end
  end

  describe 'Acceptance Criteria' do
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
