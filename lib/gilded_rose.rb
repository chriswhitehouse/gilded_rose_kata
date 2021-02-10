# frozen_string_literal: true
require './lib/modules/update_aged_brie.rb'
require './lib/modules/update_sulfuras.rb'
require './lib/modules/update_backstage_pass.rb'
require './lib/modules/update_normal.rb'
# A class for updating items
class GildedRose
  def initialize(items)
    @items = items

    @items.each do |item|
      case item.name
      when 'Aged Brie'
        item.extend(UpdateAgedBrie)
      when 'Sulfuras, Hand of Ragnaros'
        item.extend(UpdateSulfuras)
      when 'Backstage passes to a TAFKAL80ETC concert'
        item.extend(UpdateBackstagePass)
      else
        item.extend(UpdateNormal)
      end
    end
  end

  def update_quality
    @items.each do |item|
      item.update_quality
    end
  end
end
