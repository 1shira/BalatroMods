SMODS.Joker {
  key = 'black_rainbows',
  config = {
    extra = {
      odds = 11,
    }
  },
  rarity = 3,
  pos = { x = 7, y = 3 },
  atlas = 'jokers_atlas',
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,
  soul_pos = nil,

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome

    return {
      vars = {
        G.GAME.probabilities.normal,
        card.ability.extra.odds
      }
    }
  end,

  calculate = function(self, card, context)
    local ctx = context.paperback

    if not context.blueprint and ctx and ctx.modify_final_hand then
      local polychrome_triggered = false

      -- Go through each card in the scoring hand and check if it is a valid card
      for k, v in pairs(ctx.scoring_hand) do
        if (v:is_suit("Spades") or v:is_suit("Clubs")) and not v.debuff and not v.edition then
          -- If the odds succeed, set the card's edition to polychrome
          if pseudorandom('black_rainbows') < G.GAME.probabilities.normal / card.ability.extra.odds then
            polychrome_triggered = true
            v:set_edition('e_polychrome')
          end
        end
      end

      -- Display a message if a card was turned polychrome
      if polychrome_triggered then
        return {
          message = localize('paperback_polychrome_ex'),
          colour = G.C.GREEN,
          card = card
        }
      end
    end
  end
}
