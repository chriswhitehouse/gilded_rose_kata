# frozen_string_literal: true

# Logic for Sulfuras item
module SulfurasLogic
  MAX_QUALITY = 80
  MIN_QUALITY = 80

  SELL_IN_UPDATE = 0

  def quality_logic
    [
      { max_sell_in: Float::INFINITY, min_sell_in: -Float::INFINITY, change_rate: 0 }
    ]
  end
end
