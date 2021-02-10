# frozen_string_literal: true

# Module to add update logic to Item class
module ItemUpdate
  def update_quality
    self.quality += quality_update_value if in_quality_update_range

    update_sell_in
  end

  private

  def update_sell_in
    self.sell_in += singleton_class::SELL_IN_UPDATE
  end

  def in_quality_update_range
    self.quality < singleton_class::MAX_QUALITY && self.quality > singleton_class::MIN_QUALITY
  end

  def quality_update_value
    quality_logic.each do |boundary|
      return boundary[:rate] if self.sell_in <= boundary[:max] && self.sell_in >= boundary[:min]
    end
  end
end
