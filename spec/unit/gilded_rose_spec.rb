# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  let(:apple) { double :apple, name: 'apple', sell_in: 1, quality: 3, :sell_in= => true, :quality= => true }
  let(:sulfuras) do
    double :item, name: 'Sulfuras, Hand of Ragnaros', sell_in: 1, quality: 80, :sell_in= => true, :quality= => true
  end
  let(:aged_brie) { double :item, name: 'Aged Brie', sell_in: 1, quality: 5, :sell_in= => true, :quality= => true }
  let(:backstage_pass) do
    double :item, name: 'Backstage passes to a TAFKAL80ETC concert', sell_in: 11, quality: 5, :sell_in= => true,
                  :quality= => true
  end
  let(:conjured) { double :conjured, name: 'Conjured', sell_in: 1, quality: 6, :sell_in= => true, :quality= => true }
  let(:items) { [apple, sulfuras, aged_brie, backstage_pass, conjured] }
  let(:inventory) { GildedRose.new(items) }

  describe '#update_quality' do
    context 'Normal Item' do
      it 'does not change the name' do
        expect(apple).not_to receive(:name=)
        inventory.update_quality
      end

      it 'does change the sell_in' do
        expect(apple).to receive(:sell_in=).with(apple.sell_in - 1)
        inventory.update_quality
      end

      it 'qulaity decreases by 1 before sell by date has passed' do
        allow(apple).to receive(:sell_in).and_return(1)
        expect(apple).to receive(:quality=).with(apple.quality - 1)
        inventory.update_quality
      end

      it 'Once the sell by date has passed, Quality degrades twice as fast' do
        allow(apple).to receive(:sell_in).and_return(-1)
        expect(apple).to receive(:quality=).with(apple.quality - 2)
        inventory.update_quality
      end

      it 'The Quality of an item is never negative' do
        allow(apple).to receive(:quality).and_return(0)
        expect(apple).not_to receive(:quality=)
        inventory.update_quality
      end
    end

    context 'Aged Brie' do
      it "'Aged Brie' actually increases in Quality the older it gets" do
        expect(aged_brie).to receive(:quality=).with(aged_brie.quality + 1)
        inventory.update_quality
      end

      it 'The Quality of an item is never more than 50' do
        allow(aged_brie).to receive(:quality).and_return(50)
        expect(aged_brie).not_to receive(:quality=)
        inventory.update_quality
      end
    end

    context 'Sulfuras' do
      it '"Sulfuras", being a legendary item, never has to never be sold or decreases in Quality' do
        expect(sulfuras).not_to receive(:quality=)
        expect(sulfuras).to receive(:sell_in=).with(sulfuras.sell_in)
        inventory.update_quality
      end
    end

    context 'Backstage Pass' do
      it 'increase in quality by 1 with more than 10 days to sell' do
        expect(backstage_pass).to receive(:quality=).with(backstage_pass.quality + 1)
        inventory.update_quality
      end

      it 'increase in quality by 2 with less than 11, and more than 5, days to sell' do
        allow(backstage_pass).to receive(:sell_in).and_return(9)
        expect(backstage_pass).to receive(:quality=).with(backstage_pass.quality + 2)
        inventory.update_quality
      end

      it 'increase in quality by 3 with less than 5, and more than -1, days to sell' do
        allow(backstage_pass).to receive(:sell_in).and_return(4)
        expect(backstage_pass).to receive(:quality=).with(backstage_pass.quality + 3)
        inventory.update_quality
      end

      it 'quality drops to 0 after the concert' do
        allow(backstage_pass).to receive(:sell_in).and_return(-1)
        expect(backstage_pass).to receive(:quality=).with(0)
        inventory.update_quality
      end

      it 'quality is never more than 50' do
        allow(backstage_pass).to receive(:quality).and_return(50)
        expect(backstage_pass).not_to receive(:quality=)
        inventory.update_quality
      end

      it 'quality is increases by 3 when sell_in is equal to 0' do
        allow(backstage_pass).to receive(:sell_in).and_return(0)
        expect(backstage_pass).not_to receive(:quality=).with(3)
        inventory.update_quality
      end
    end

    context 'Conjured Item' do
      it 'qulaity decreases by 2 before sell by date has passed' do
        allow(conjured).to receive(:sell_in).and_return(1)
        expect(conjured).to receive(:quality=).with(conjured.quality - 2)
        inventory.update_quality
      end

      it 'Once the sell by date has passed, Quality degrades twice as fast' do
        allow(conjured).to receive(:sell_in).and_return(-1)
        expect(conjured).to receive(:quality=).with(conjured.quality - 4)
        inventory.update_quality
      end
    end
  end
end
