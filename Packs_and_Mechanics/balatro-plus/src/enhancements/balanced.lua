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

function e:calculate(card, ctx)
  if ctx.cardarea == G.play and not ctx.repetition then
    local balanced = ((card.chips or 0) + (card.mult or 0)) / 2
    if balanced <= 0 then
      balanced = nil
    end
    return {
        chips = balanced,
        mult = balanced
    }
  end
end

return e
