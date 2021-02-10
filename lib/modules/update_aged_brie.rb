module UpdateAgedBrie
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  SELL_IN_UPDATE = -1

  QUALITY_UPDATE_BEFORE_SELL_BY_DATE = 1
  QUALITY_UPDATE_AFTER_SELL_BY_DATE = 2


  def update_quality
    update_sell_in

    return unless in_quality_update_range
      self.quality += quality_update_value
  end

  private

  def update_sell_in
    self.sell_in += SELL_IN_UPDATE
  end

  def in_quality_update_range
    self.quality < MAX_QUALITY && self.quality > MIN_QUALITY
  end

  def quality_update_value
    after_sell_by_date ? QUALITY_UPDATE_AFTER_SELL_BY_DATE : QUALITY_UPDATE_BEFORE_SELL_BY_DATE
  end

  def after_sell_by_date
    self.sell_in.negative?
  end
end
