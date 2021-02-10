module UpdateBackstagePass
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
