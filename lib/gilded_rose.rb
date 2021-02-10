# frozen_string_literal: true

# A class for updating items
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        update_quality_aged_brie(item)
      when 'Sulfuras, Hand of Ragnaros'
        update_quality_sulfuras(item)
      when 'Backstage passes to a TAFKAL80ETC concert'
        update_quality_backstage_pass(item)
      else
        update_quality_normal(item)
      end
    end
  end

  private

  def update_quality_aged_brie(item)
    item.sell_in -= 1

    return unless item.quality < 50 && item.quality.positive?

    item.quality -= item.sell_in.negative? ? -2 : -1
  end

  def update_quality_sulfuras(item); end

  def update_quality_backstage_pass(item)
    item.sell_in -= 1

    return unless item.quality < 50 && item.quality.positive?

    if item.sell_in >= 10
      item.quality += 1
    elsif item.sell_in >= 5
      item.quality += 2
    elsif item.sell_in.positive?
      item.quality += 3
    else
      item.quality = 0
    end
  end

  def update_quality_normal(item)
    item.sell_in -= 1

    return unless item.quality < 50 && item.quality.positive?

    item.quality -= item.sell_in.negative? ? 2 : 1
  end
end
