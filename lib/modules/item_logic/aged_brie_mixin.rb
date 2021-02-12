# frozen_string_literal: true

# Logic for Aged Brie item
module AgedBrieLogic
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  SELL_IN_UPDATE = -1

  def quality_logic
    [
      { max_sell_in: Float::INFINITY, min_sell_in: 1, change_rate: 1 },
      { max_sell_in: 0, min_sell_in: -Float::INFINITY, change_rate: 2 }
    ]
  end
end
