# frozen_string_literal: true
require './lib/modules/item_logic/aged_brie.rb'
require './lib/modules/item_logic/sulfuras.rb'
require './lib/modules/item_logic/backstage_pass.rb'
require './lib/modules/item_logic/normal.rb'

require './lib/modules/item_update.rb'
# A class for updating items
class GildedRose
  def initialize(items)
    @items = items

    @items.each do |item|
      item.extend(ItemUpdate)

      case item.name
      when 'Aged Brie'
        item.extend(AgedBrieLogic)
      when 'Sulfuras, Hand of Ragnaros'
        item.extend(SulfurasLogic)
      when 'Backstage passes to a TAFKAL80ETC concert'
        item.extend(BackstagePassLogic)
      else
        item.extend(NormalLogic)
      end
    end
  end

  def update_quality
    @items.each do |item|
      item.update_quality
    end
  end
end
