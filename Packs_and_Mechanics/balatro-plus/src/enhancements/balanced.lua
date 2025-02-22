local e = {
  loc_txt = {
    name = "Balanced Card",
    text = {
      "{C:attention}Balance{} this card",
      "{C:chips}Chips{} and {C:mult}Mult",
    },
  },
  atlas = 3,
}

function e:calculate(card, ctx, effect)
  if ctx.cardarea == G.play and not ctx.repetition then
    local balanced = ((effect.chips or 0) + (effect.mult or 0)) / 2
    if balanced <= 0 then
      balanced = nil
    end
    effect.chips = balanced
    effect.mult = balanced
  end
end

return e
