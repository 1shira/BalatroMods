--- STEAMODDED HEADER
--- MOD_NAME: Pact Deck
--- MOD_ID: PactDeck
--- MOD_AUTHOR: [Blackbando]
--- MOD_DESCRIPTION: A deck with low Joker slots, and high Negative Jokers!
--- PREFIX: pactdeck

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas{
	key = "deck",
	path = "b_pact.png",
	px = 71,
	py = 95
}:register()
	
-- Using the "AbsoluteDeck" mod as an example

SMODS.Back{
	name = "Pact Deck",
	key = "pact_deck",
	pos = {x = 0, y = 0},
	config = { joker_slot = -1,
		hands = -1
	},
	atlas = "pactdeck_deck",
	loc_txt = {
		name = "Pact Deck",
		text = {
			"After defeating each",
			"{C:attention}Boss Blind{}, gain a",
			"{C:dark_edition,T:tag_negative}Negative Tag{}",
			"{C:red}-1{} Joker slot, {C:red}-1{} {C:blue}Hand{} per round"
		}
	}
}

local Backtrigger_effectref = Back.trigger_effect
function Back.trigger_effect(self, args)
  if self.name == 'Pact Deck' and args.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss then
    G.E_MANAGER:add_event(Event({
      func = (function()
        add_tag(Tag('tag_negative'))
        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
        return true
      end)
    }))
  end
  
  return Backtrigger_effectref(self, args)
end
----------------------------------------------
------------MOD CODE END----------------------
