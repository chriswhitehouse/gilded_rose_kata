module UpdateNormal
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  SELL_IN_UPDATE = -1

  def boundaries(logic)
    @logic = logic
  end


  def update_quality
    if in_quality_update_range
      self.quality += quality_update_value
    end

    update_sell_in
  end

  private

  def update_sell_in
    self.sell_in += SELL_IN_UPDATE
  end

  def in_quality_update_range
    self.quality < MAX_QUALITY && self.quality > MIN_QUALITY
  end

  def quality_update_value
    @logic.each do |boundary|
      if self.sell_in <= boundary[:max] && self.sell_in >= boundary[:min]
        return boundary[:rate]
      end
    end
  end

  def after_sell_by_date
    self.sell_in.negative?
  end
end
