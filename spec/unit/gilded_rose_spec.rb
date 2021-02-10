# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  # let(:apple) { double :item, name: "apple", sell_in: 1, quality: 3 }
  # let(:banana) { double :item, name: "banana", sell_in: 2, quality: 4 }
  # let(:aged_brie) { double :item, name: "Aged Brie", sell_in: 1, quality: 5 }
  # let(:sulfuras) { double :item, name: "Sulfuras, Hand of Ragnaros", sell_in: 1, quality: 80 }
  # let(:backstage_pass) { double :item, name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 11, quality: 5 }
  #
  #
  # let(:items) { [
  #                 apple,
  #                 banana,
  #                 aged_brie,
  #                 sulfuras,
  #                 backstage_pass,
  #               ] }
  #
  # let(:inventory) { GildedRose.new(items) }

  describe '#update_quality' do
    context 'one normal item' do
      let(:apple) { spy :apple, name: 'apple' }
      let(:items) { [apple] }
      let(:inventory) { GildedRose.new(items) }

      it 'does not change the name' do
        inventory.update_quality
        expect(apple).not_to have_received(:name=)
      end


      it 'does change the sell_in for all items except Sulfuras' do
        inventory.update_quality
        expect(apple).to have_received(:sell_in=)
      end

    end

    # it 'Once the sell by date has passed, Quality degrades twice as fast' do
    #   expect { inventory.update_quality }.to change { items[0].quality }.by(-1)
    #   expect { inventory.update_quality }.to change { items[0].quality }.by(-2)
    # end
    #
    # it 'The Quality of an item is never negative' do
    #   inventory.update_quality
    #   inventory.update_quality
    #   inventory.update_quality
    #   expect(items[0].quality).not_to be <0
    # end
    #
    # it "'Aged Brie' actually increases in Quality the older it gets" do
    #   expect { inventory.update_quality }.to change { items[2].quality }.by(1)
    #   expect { inventory.update_quality }.to change { items[2].quality }.by(2)
    # end
    #
    # it 'The Quality of an item is never more than 50' do
    #   50.times { inventory.update_quality }
    #   expect(items[2].quality).not_to be >50
    # end
    #
    # it '"Sulfuras", being a legendary item, never has to be sold or decreases in Quality' do
    #   expect { inventory.update_quality }.not_to change { items[3].sell_in }
    #   expect { inventory.update_quality }.not_to change { items[3].quality }
    # end
    #
    # it '"Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
    # Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
    # Quality drops to 0 after the concert' do
    #   expect { inventory.update_quality }.to change { items[4].quality }.by(1)
    #   expect { inventory.update_quality }.to change { items[4].quality }.by(2)
    #   4.times { inventory.update_quality }
    #   expect { inventory.update_quality }.to change { items[4].quality }.by(3)
    #   5.times { inventory.update_quality }
    #   expect(items[4].quality).to eq 0
    # end
  end
end
