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
    it 'manages a portfolio of items over time' do
      # First quality_update
      expect { inventory.update_quality }
        .to change { items[0].quality }.by(-1)
        .and change { items[1].quality }.by(-1)
        .and change { items[2].quality }.by(1)
        .and change { items[3].sell_in }.by(0)
        .and change { items[4].quality }.by(1)

      # Second quality_update
      expect { inventory.update_quality }
        .to change { items[0].quality }.by(-2)
        .and change { items[1].quality }.by(-1)
        .and change { items[2].quality }.by(2)
        .and change { items[3].quality }.by(0)
        .and change { items[4].quality }.by(2)

      # Third quality_update
      expect { inventory.update_quality }
        .to change { items[0].quality }.by(0)
        .and change { items[1].quality }.by(-2)
        .and change { items[2].quality }.by(2)
        .and change { items[3].quality }.by(0)
        .and change { items[4].quality }.by(2)

      3.times { inventory.update_quality }

      # Seventh Quality Update
      expect { inventory.update_quality }.to change { items[4].quality }.by(3)

      5.times { inventory.update_quality }

      # After 12th Quality Update
      expect(items[4].quality).to eq 0

      39.times { inventory.update_quality }

      # After 51st Quality update
      expect(items[2].quality).not_to be >50

    end
  end
end
