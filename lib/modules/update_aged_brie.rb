module UpdateAgedBrie
  def update_quality
    self.sell_in -= 1

    return unless self.quality < 50 && self.quality.positive?

    self.quality -= self.sell_in.negative? ? -2 : -1
  end
end
