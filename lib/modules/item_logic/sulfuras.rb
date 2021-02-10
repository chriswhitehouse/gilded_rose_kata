# frozen_string_literal: true

# Logic for Sulfuras item
module SulfurasLogic
  MAX_QUALITY = 80
  MIN_QUALITY = 80

  SELL_IN_UPDATE = 0

  def quality_logic
    [
      { max: Float::INFINITY, min: 1, rate: 0 },
      { max: 0, min: -Float::INFINITY, rate: 0 }
    ]
  end
end