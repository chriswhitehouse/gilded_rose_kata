# frozen_string_literal: true

# A class for updating items
class GildedRose
  def initialize(items)
    @items = items

    @items.each do |item|
      case item.name
      when 'Aged Brie'
        item.extend(Update_aged_brie)
      when 'Sulfuras, Hand of Ragnaros'
        item.extend(Update_sulfuras)
      when 'Backstage passes to a TAFKAL80ETC concert'
        item.extend(Update_backstage_pass)
      else
        item.extend(Update_normal)
      end
    end
  end

  def update_quality
    @items.each do |item|
      item.update_quality
    end
  end

  private

  module Update_aged_brie
    def update_quality
      self.sell_in -= 1

      return unless self.quality < 50 && self.quality.positive?

      self.quality -= self.sell_in.negative? ? -2 : -1
    end
  end

  module Update_sulfuras
    def update_quality
    end
  end

  module Update_backstage_pass
    def update_quality
      self.sell_in -= 1

      return unless self.quality < 50 && self.quality.positive?

      if self.sell_in >= 10
        self.quality += 1
      elsif self.sell_in >= 5
        self.quality += 2
      elsif self.sell_in.positive?
        self.quality += 3
      else
        self.quality = 0
      end
    end
  end

  module Update_normal
    def update_quality
      self.sell_in -= 1

      return unless self.quality < 50 && self.quality.positive?

      self.quality -= self.sell_in.negative? ? 2 : 1
    end
  end
end
