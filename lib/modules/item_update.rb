module ItemUpdate
  def update_quality
    if in_quality_update_range
      self.quality += quality_update_value
    end

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
      if self.sell_in <= boundary[:max] && self.sell_in >= boundary[:min]
        return boundary[:rate]
      end
    end
  end

  def after_sell_by_date
    self.sell_in.negative?
  end
end
