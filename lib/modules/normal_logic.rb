module NormalLogic
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  SELL_IN_UPDATE = -1

  def quality_logic
    [
   {max: Float::INFINITY, min: 1, rate: -1},
   {max: 0, min: -Float::INFINITY, rate: -2 },
    ]
  end
end
