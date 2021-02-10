# frozen_string_literal: true

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name == 'Aged Brie'
        update_quality_aged_brie(item)
      elsif item.name == 'Sulfuras, Hand of Ragnaros'
        update_quality_sulfuras(item)
      elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
        update_quality_backstage_pass(item)
      else
        update_quality_normal(item)
      end
    end
  end

  private

  def update_quality_aged_brie(item)
    item.sell_in -= 1

    if item.quality < 50 && item.quality > 0
      if item.sell_in < 0
        item.quality += 2
      else
        item.quality += 1
      end
    end
  end

  def update_quality_sulfuras(item)
    item.sell_in
    item.quality
  end

  def update_quality_backstage_pass(item)
    item.sell_in -= 1

    if item.quality < 50 && item.quality > 0
      if item.sell_in >= 10
        item.quality += 1
      elsif item.sell_in >= 5
        item.quality += 2
      elsif item.sell_in > 0
        item.quality += 3
      else
        item.quality = 0
      end
    end
  end

  def update_quality_normal(item)
    item.sell_in -= 1

    if item.quality < 50 && item.quality > 0
      if item.sell_in < 0
        item.quality -= 2
      else
        item.quality -= 1
      end
    end
  end
end
