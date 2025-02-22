--- STEAMODDED HEADER
--- MOD_NAME: Stylish Sleeves Challenge
--- MOD_ID: StylishSleeves
--- MOD_AUTHOR: [Aure]
--- MOD_DESCRIPTION: Adds the Stylish Sleeves Challenge to the game: The effects of all base game decks apply, X2 base blind score.

----------------------------------------------
------------MOD CODE -------------------------

function SMODS.INIT.StylishSleeves()
	G.localization.misc.challenge_names["c_sleeves_1"] = "Stylish Sleeves"

	local c = {
		name = "Stylish Sleeves",
		id = "c_sleeves_1",
		rules = {
			modifiers = {
				{ id = "consumable_slots", value = 1 },
				{ id = "hand_size",        value = 10 },
				{ id = "discards",         value = 4 },
				{ id = "dollars",          value = 14 },
			},
			custom = {
				{ id = "no_interest" },
			}
		},
		consumeables = {
			{ id = "c_fool" },
			{ id = "c_fool" },
			{ id = "c_hex" }
		},
		vouchers = {
			{ id = "v_crystal_ball" },
			{ id = "v_telescope" },
			{ id = "v_tarot_merchant" },
			{ id = "v_planet_merchant" },
			{ id = "v_overstock_norm" }
		},
		deck = {
			type = "Challenge Deck",
		}
	}
	G.CHALLENGES[#G.CHALLENGES + 1] = c

	Game.start_run_ref = Game.start_run
	function Game:start_run(args)
		self:start_run_ref(args)
		if G.GAME.challenge == "c_sleeves_1" then
			G.GAME.starting_params.ante_scaling = 4
			G.GAME.spectral_rate = 2
			G.GAME.modifiers.money_per_hand = 2
			G.GAME.modifiers.money_per_discard = 1
		end
	end

	local card_from_control_ref = card_from_control
	function card_from_control(control)
		if G.GAME.challenge ~= "c_sleeves_1" then return card_from_control_ref(control) end
		local r, s = control.r, control.s
		if (r == "J") or (r == "Q") or (r == "K") then return end
		if s == "D" then s = "H" end
		if s == "C" then s = "S" end
        r = pseudorandom_element({ 'A', '2', '3', '4', '5', '6', '7', '8', '9', 'T' })
		control.r, control.s = r, s
		return card_from_control_ref(control)
	end

	local Back_trigger_effect_ref = Back.trigger_effect
	function Back.trigger_effect(arg_56_0, args)
		if G.GAME.challenge == "c_sleeves_1" then
			if args.context == 'final_scoring_step' then
				local tot = args.chips + args.mult
				args.chips = math.floor(tot / 2)
				args.mult = math.floor(tot / 2)
				update_hand_text({ delay = 0 }, { mult = args.mult, chips = args.chips })

				G.E_MANAGER:add_event(Event({
					func = (function()
						local text = localize('k_balanced')
						play_sound('gong', 0.94, 0.3)
						play_sound('gong', 0.94 * 1.5, 0.2)
						play_sound('tarot1', 1.5)
						ease_colour(G.C.UI_CHIPS, { 0.8, 0.45, 0.85, 1 })
						ease_colour(G.C.UI_MULT, { 0.8, 0.45, 0.85, 1 })
						attention_text({
							scale = 1.4,
							text = text,
							hold = 2,
							align = 'cm',
							offset = { x = 0, y = -2.7 },
							major = G
								.play
						})
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							blockable = false,
							blocking = false,
							delay = 4.3,
							func = (function()
								ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
								ease_colour(G.C.UI_MULT, G.C.RED, 2)
								return true
							end)
						}))
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							blockable = false,
							blocking = false,
							no_delete = true,
							delay = 6.3,
							func = (function()
								G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1],
									G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
								G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2],
									G.C.RED[3], G.C.RED[4]
								return true
							end)
						}))
						return true
					end)
				}))

				delay(0.6)
				return args.chips, args.mult
			elseif args.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss then
				G.E_MANAGER:add_event(Event({
					func = (function()
						add_tag(Tag('tag_double'))
						play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
						play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
						return true
					end)
				}))
			end
			return Back_trigger_effect_ref(arg_56_0, args)
		end
	end
end

----------------------------------------------
------------MOD CODE END----------------------
