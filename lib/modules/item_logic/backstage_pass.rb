# frozen_string_literal: true

# Logic for Backstage Pass item
module BackstagePassLogic
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  SELL_IN_UPDATE = -1

  def quality_logic
    [
      { max: Float::INFINITY, min: 11, rate: 1 },
      { max: 10, min: 6, rate: 2 },
      { max: 5, min: 1, rate: 3 },
      { max: 0, min: -Float::INFINITY, rate: -quality }
    ]
  end
end
