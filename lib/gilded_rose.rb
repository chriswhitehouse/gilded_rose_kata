# frozen_string_literal: true

require './lib/modules/item_logic/aged_brie'
require './lib/modules/item_logic/sulfuras'
require './lib/modules/item_logic/backstage_pass'
require './lib/modules/item_logic/conjured'
require './lib/modules/item_logic/normal'

require './lib/modules/item_update'
# A class for updating items
class GildedRose
  LOGIC_HASH = {
    'Aged Brie' => AgedBrieLogic,
    'Sulfuras, Hand of Ragnaros' => SulfurasLogic,
    'Backstage passes to a TAFKAL80ETC concert' => BackstagePassLogic,
    'Conjured' => ConjuredLogic
  }.freeze

  def initialize(items)
    @items = items

    extend_logic_to_items
  end

  def update_quality
    @items.each(&:update_quality)
  end

  private

  def extend_logic_to_items
    @items.each do |item|
      item.extend(ItemUpdate)
      LOGIC_HASH[item.name] ? item.extend(LOGIC_HASH[item.name]) : item.extend(NormalLogic)
    end
  end
end
