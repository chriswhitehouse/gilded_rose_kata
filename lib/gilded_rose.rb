# frozen_string_literal: true
Dir[File.join(__dir__, '/modules/item_logic/', '*.rb')].each { |file| require file }
require './lib/modules/item_update_mixin.rb'
require './lib/item.rb'
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
