module UpdateBackstagePass
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  SELL_IN_UPDATE = -1

  QUALITY_UPDATE_BEFORE_TEN_DAYS = 1
  QUALITY_UPDATE_BEFORE_FIVE_DAYS = 2
  QUALITY_UPDATE_BEFORE_ZERO_DAYS = 3
  QUALITY_UPDATE_AFTER_SELL_BY_DATE = 0


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
    if self.sell_in >= 10
      QUALITY_UPDATE_BEFORE_TEN_DAYS
    elsif self.sell_in >= 5
      QUALITY_UPDATE_BEFORE_FIVE_DAYS
    elsif self.sell_in.positive?
      QUALITY_UPDATE_BEFORE_ZERO_DAYS
    else
      -self.quality
    end
  end

  def after_sell_by_date
    self.sell_in.negative?
  end
end
