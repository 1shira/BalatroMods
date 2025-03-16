--TIP!!! for coding exotics, make sure you know which layer corresponds to which value!
--The Normal pos correponds to the background. use this for the layer that goes all the way in the back!
--The soul_pos = {blahblahblah, extra = {blahblahblah}} correspomds to the other two layers. the value in the extra table is for the layer that goes in the middle, and the other value is the one that goes all the way in the front
local gateway = {
	dependencies = {
		items = {
			"set_cry_exotic",
		},
	},
	object_type = "Consumable",
	set = "Spectral",
	name = "cry-Gateway",
	key = "gateway",
	pos = { x = 0, y = 0 },
	cost = 4,
	atlas = "atlasnotjokers",
	order = 90,
	hidden = true, --default soul_set and soul_rate of 0.3% in spectral packs is used
	can_use = function(self, card)
		if (#SMODS.find_card("j_jen_saint") + #SMODS.find_card("j_jen_saint_attuned")) > 0 then
			return #G.jokers.cards < G.jokers.config.card_limit
		else
			--Don't allow use if everything is eternal and there is no room
			return #Cryptid.advanced_find_joker(nil, nil, nil, { "eternal" }, true, "j") < G.jokers.config.card_limit
		end
	end,
	use = function(self, card, area, copier)
		if (#SMODS.find_card("j_jen_saint") + #SMODS.find_card("j_jen_saint_attuned")) <= 0 then
			local deletable_jokers = {}
			for k, v in pairs(G.jokers.cards) do
				if not v.ability.eternal then
					deletable_jokers[#deletable_jokers + 1] = v
				end
			end
			local _first_dissolve = nil
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.75,
				func = function()
					for k, v in pairs(deletable_jokers) do
						if v.config.center.rarity == "cry_exotic" then
							check_for_unlock({ type = "what_have_you_done" })
						end
						v:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
					end
					return true
				end,
			}))
		end
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, "cry_exotic", nil, nil, nil, "cry_gateway")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
	end,
}
local iterum = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-Iterum",
	key = "iterum",
	config = { extra = { x_mult = 2, repetitions = 1 } },
	pos = { x = 0, y = 1 },
	rarity = "cry_exotic",
	order = 500,
	cost = 50,
	blueprint_compat = true,
	atlas = "atlasexotic",
	soul_pos = { x = 1, y = 1, extra = { x = 2, y = 1 } },
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.x_mult, math.min(40, center.ability.extra.repetitions) } }
	end,
	calculate = function(self, card, context)
		if context.repetition then
			if context.cardarea == G.play then
				return {
					message = localize("k_again_ex"),
					repetitions = math.min(40, card.ability.extra.repetitions),
					card = card,
				}
			end
		elseif context.individual then
			if context.cardarea == G.play then
				return {
					x_mult = card.ability.extra.x_mult,
					colour = G.C.RED,
					card = card,
				}
			end
		end
	end,
	cry_credits = {
		idea = { "Math" },
		art = { "Ein13" },
		code = { "Math" },
	},
}
local universum = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-Universum",
	key = "universum",
	config = { extra = 2 },
	pos = { x = 3, y = 3 },
	rarity = "cry_exotic",
	cost = 50,
	order = 501,
	blueprint_compat = true,
	atlas = "atlasexotic",
	soul_pos = { x = 4, y = 3, extra = { x = 5, y = 3 } },
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra } }
	end,
	calculate = function(self, card, context)
		if context.cry_universum then
			return {
				mod = to_big(card.ability.extra),
				colour = G.C.DARK_EDITION,
				message = localize("k_upgrade_ex"),
			}
		end
	end,
	cry_credits = {
		idea = { "Ein13" },
		art = { "Ein13", "hydro" },
	},
	init = function(self)
		--Universum Patches
		local uht = update_hand_text
		function update_hand_text(config, vals)
			if next(find_joker("cry-Universum")) and not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({ --This is the Hand name text for the poker hand
					trigger = "before",
					blockable = not config.immediate,
					delay = config.delay or 0.8,
					func = function()
						local col = G.C.GREEN
						if vals.chips and G.GAME.current_round.current_hand.chips ~= vals.chips then
							local delta = vals.chips
							if is_number(vals.chips) and is_number(G.GAME.current_round.current_hand.chips) then
								delta = "X" .. number_format(vals.chips / G.GAME.current_round.current_hand.chips)
							end
							G.GAME.current_round.current_hand.chips = vals.chips
							G.hand_text_area.chips:update(0)
							if vals.StatusText then
								attention_text({
									text = delta,
									scale = 0.8,
									hold = 1,
									cover = G.hand_text_area.chips.parent,
									cover_colour = mix_colours(G.C.CHIPS, col, 0.1),
									emboss = 0.05,
									align = "cm",
									cover_align = "cr",
								})
							end
						end
						if vals.mult and G.GAME.current_round.current_hand.mult ~= vals.mult then
							local delta = vals.mult
							if is_number(vals.mult) and is_number(G.GAME.current_round.current_hand.mult) then
								delta = "X" .. number_format(vals.mult / G.GAME.current_round.current_hand.mult)
							end
							G.GAME.current_round.current_hand.mult = vals.mult
							G.hand_text_area.mult:update(0)
							if vals.StatusText then
								attention_text({
									text = delta,
									scale = 0.8,
									hold = 1,
									cover = G.hand_text_area.mult.parent,
									cover_colour = mix_colours(G.C.MULT, col, 0.1),
									emboss = 0.05,
									align = "cm",
									cover_align = "cl",
								})
							end
							if not G.TAROT_INTERRUPT then
								G.hand_text_area.mult:juice_up()
							end
						end
						if vals.handname and G.GAME.current_round.current_hand.handname ~= vals.handname then
							G.GAME.current_round.current_hand.handname = vals.handname
							if not config.nopulse then
								G.hand_text_area.handname.config.object:pulse(0.2)
							end
						end
						if vals.chip_total then
							G.GAME.current_round.current_hand.chip_total = vals.chip_total
							G.hand_text_area.chip_total.config.object:pulse(0.5)
						end
						if
							vals.level
							and G.GAME.current_round.current_hand.hand_level
								~= " " .. localize("k_lvl") .. tostring(vals.level)
						then
							if vals.level == "" then
								G.GAME.current_round.current_hand.hand_level = vals.level
							else
								G.GAME.current_round.current_hand.hand_level = " "
									.. localize("k_lvl")
									.. tostring(vals.level)
								if is_number(vals.level) then
									G.hand_text_area.hand_level.config.colour =
										G.C.HAND_LEVELS[to_big(math.min(vals.level, 7)):to_number()]
								else
									G.hand_text_area.hand_level.config.colour = G.C.HAND_LEVELS[1]
								end
								G.hand_text_area.hand_level:juice_up()
							end
						end
						if config.sound and not config.modded then
							play_sound(config.sound, config.pitch or 1, config.volume or 1)
						end
						if config.modded then
							if
								G.HUD_blind
								and G.HUD_blind.get_UIE_by_ID
								and G.HUD_blind:get_UIE_by_ID("HUD_blind_debuff_1")
								and G.HUD_blind:get_UIE_by_ID("HUD_blind_debuff_2")
							then
								G.HUD_blind:get_UIE_by_ID("HUD_blind_debuff_1"):juice_up(0.3, 0)
								G.HUD_blind:get_UIE_by_ID("HUD_blind_debuff_2"):juice_up(0.3, 0)
							end
							G.GAME.blind:juice_up()
							G.E_MANAGER:add_event(Event({
								trigger = "after",
								delay = 0.06 * G.SETTINGS.GAMESPEED,
								blockable = false,
								blocking = false,
								func = function()
									play_sound("tarot2", 0.76, 0.4)
									return true
								end,
							}))
							play_sound("tarot2", 1, 0.4)
						end
						return true
					end,
				}))
			else
				uht(config, vals)
			end
		end
	end,
}
local exponentia = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-Exponentia",
	key = "exponentia",
	config = { extra = { Emult = 1, Emult_mod = 0.03 } },
	pos = { x = 0, y = 0 },
	rarity = "cry_exotic",
	cost = 50,
	blueprint_compat = true,
	perishable_compat = false,
	atlas = "atlasexotic",
	order = 503,
	soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Emult) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_powmult",
					vars = {
						number_format(card.ability.extra.Emult),
					},
				}),
				Emult_mod = card.ability.extra.Emult,
				colour = G.C.DARK_EDITION,
			}
		end
	end,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Emult_mod, center.ability.extra.Emult } }
	end,
	cry_credits = {
		idea = { "Enemui" },
		art = { "Jevonn" },
		code = { "Math" },
	},
	init = function(self)
		-- Hook for scaling
		local scie = SMODS.calculate_individual_effect
		function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
			local ret = scie(effect, scored_card, key, amount, from_edition)
			if (key == "x_mult" or key == "xmult" or key == "x_mult_mod" or key == "Xmult_mod") and amount ~= 1 then
				for _, v in pairs(find_joker("cry-Exponentia")) do
					local old = v.ability.extra.Emult
					v.ability.extra.Emult = v.ability.extra.Emult + v.ability.extra.Emult_mod
					card_eval_status_text(v, "extra", nil, nil, nil, {
						message = localize({
							type = "variable",
							key = "a_powmult",
							vars = { number_format(to_big(v.ability.extra.Emult)) },
						}),
					})
					Cryptid.exponentia_scale_mod(v, v.ability.extra.Emult_mod, old, v.ability.extra.Emult)
				end
			end
			return ret
		end
	end,
}
local speculo = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-Speculo",
	key = "speculo",
	pos = { x = 3, y = 1 },
	rarity = "cry_exotic",
	cost = 50,
	blueprint_compat = true,
	immutable = true,
	atlas = "atlasexotic",
	order = 504,
	soul_pos = { x = 4, y = 1, extra = { x = 5, y = 1 } },
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.negative) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		end
	end,
	calculate = function(self, card, context)
		if context.ending_shop then
			local eligibleJokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.name ~= card.ability.name and G.jokers.cards[i].ability.set == "Joker" then
					eligibleJokers[#eligibleJokers + 1] = G.jokers.cards[i]
				end
			end
			if #eligibleJokers > 0 then
				G.E_MANAGER:add_event(Event({
					func = function()
						local card = copy_card(pseudorandom_element(eligibleJokers, pseudoseed("cry_speculo")), nil)
						card:set_edition({ negative = true }, true)
						card:add_to_deck()
						G.jokers:emplace(card)
						return true
					end,
				}))
				card_eval_status_text(
					context.blueprint_card or card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_duplicated_ex") }
				)
				return nil, true
			end
			return
		end
	end,
	cry_credits = {
		idea = { "Mystic" },
		art = { "Mystic" },
		code = { "Math" },
	},
}
local redeo = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-Redeo",
	key = "redeo",
	config = { extra = { ante_reduction = 1, money_req = 10, money_remaining = 0, money_mod = 10 } },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.extra.ante_reduction,
				center.ability.extra.money_req,
				center.ability.extra.money_remaining,
				center.ability.extra.money_mod,
			},
		}
	end,
	pos = { x = 3, y = 0 },
	rarity = "cry_exotic",
	cost = 50,
	order = 506,
	atlas = "atlasexotic",
	soul_pos = { x = 4, y = 0, extra = { x = 5, y = 0 } },
	calculate = function(self, card, context)
		if context.cry_ease_dollars and to_big(context.cry_ease_dollars) < to_big(0) and not context.blueprint then
			card.ability.extra.money_remaining = card.ability.extra.money_remaining - context.cry_ease_dollars
			local ante_mod = 0
			while to_big(card.ability.extra.money_remaining) >= to_big(card.ability.extra.money_req) do
				card.ability.extra.money_remaining = card.ability.extra.money_remaining - card.ability.extra.money_req
				card.ability.extra.money_req = card.ability.extra.money_req + card.ability.extra.money_mod
				card.ability.extra.money_mod = math.min(1e300, math.ceil(card.ability.extra.money_mod * 1.06))
				ante_mod = ante_mod - card.ability.extra.ante_reduction
			end
			if ante_mod < 0 then
				ease_ante(ante_mod)
			end
			return nil, true
		end
	end,
	cry_credits = {
		idea = { "Enemui" },
		art = { "Jevonn", "Darren_The_Frog" },
		code = { "Math", "jenwalter666" },
	},
	init = function(self)
		local ed = ease_dollars
		function ease_dollars(mod, x)
			ed(mod, x)
			for i = 1, #G.jokers.cards do
				local effects = G.jokers.cards[i]:calculate_joker({ cry_ease_dollars = mod })
			end
		end
	end,
}
local tenebris = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-Tenebris",
	key = "tenebris",
	pos = { x = 3, y = 2 },
	soul_pos = { x = 4, y = 2, extra = { x = 5, y = 2 } },
	config = { extra = { slots = 25, money = 25 } },
	rarity = "cry_exotic",
	cost = 50,
	order = 507,
	atlas = "atlasexotic",
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.money
	end,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.slots, center.ability.extra.money } }
	end,
	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
	end,
	cry_credits = {
		idea = { "Gold" },
		art = { "Mystic" },
		code = { "jenwalter666" },
	},
}
local effarcire = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-Effarcire",
	key = "effarcire",
	config = {},
	immutable = true,
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0, extra = { x = 2, y = 0 } },
	cost = 50,
	order = 505,
	atlas = "effarcire",
	rarity = "cry_exotic",
	calculate = function(self, card, context)
		if not context.blueprint and not context.retrigger_joker then
			if context.first_hand_drawn then
				G.FUNCS.draw_from_deck_to_hand(#G.deck.cards)
				return nil, true
			elseif G.hand.config.card_limit < 1 then
				G.hand.config.card_limit = 1
			end
		end
	end,
	cry_credits = {
		idea = { "Frix" },
		art = { "AlexZGreat", "Catformer" },
		code = { "jenwalter666" },
	},
}
local effarcire_sprite = {
	object_type = "Atlas",
	key = "effarcire",
	path = "goofy.png",
	px = 71,
	py = 95,
}
local crustulum = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-crustulum",
	key = "crustulum",
	config = { extra = { chips = 0, chip_mod = 4 } },
	pos = { x = 0, y = 2 },
	soul_pos = { x = 2, y = 2, extra = { x = 1, y = 2 } },
	rarity = "cry_exotic",
	cost = 50,
	order = 508,
	atlas = "atlasexotic",
	blueprint_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips, center.ability.extra.chip_mod } }
	end,
	calculate = function(self, card, context)
		if context.reroll_shop and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } }),
				colour = G.C.CHIPS,
			})
			return nil, true
		end
		if context.joker_main and to_big(card.ability.extra.chips) > to_big(0) then
			return {
				message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } }),
				chip_mod = card.ability.extra.chips,
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		--This makes the reroll immediately after obtaining free because the game doesn't do that for some reason
		G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + 1
		calculate_reroll_cost(true)
	end,
	remove_from_deck = function(self, card, from_debuff)
		calculate_reroll_cost(true)
	end,
	cry_credits = {
		idea = { "AlexZGreat" },
		art = { "lolxddj" },
		code = { "Jevonn" },
	},
}
--todo: make the Emult always prime
local primus = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-primus",
	key = "primus",
	config = { extra = { Emult = 1.01, Emult_mod = 0.17 } },
	pos = { x = 0, y = 4 },
	rarity = "cry_exotic",
	cost = 53,
	order = 510,
	blueprint_compat = true,
	perishable_compat = false,
	atlas = "atlasexotic",
	soul_pos = { x = 2, y = 4, extra = { x = 1, y = 4 } },
	calculate = function(self, card, context)
		local check = true
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			if context.scoring_hand then
				for k, v in ipairs(context.full_hand) do
					if
						v:get_id() == 4
						or v:get_id() == 6
						or v:get_id() == 8
						or v:get_id() == 9
						or v:get_id() == 10
						or v:get_id() == 11
						or v:get_id() == 12
						or v:get_id() == 13
					then
						check = false
					end
				end
			end
			if check then
				card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_mod
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize("k_upgrade_ex"),
						colour = G.C.DARK_EDITION,
					}),
				}
			end
		end
		if context.joker_main and (to_big(card.ability.extra.Emult) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_powmult",
					vars = {
						number_format(card.ability.extra.Emult),
					},
				}),
				Emult_mod = card.ability.extra.Emult,
				colour = G.C.DARK_EDITION,
			}
		end
	end,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Emult_mod, center.ability.extra.Emult } }
	end,
	cry_credits = {
		idea = { "Jevonn" },
		art = { "Jevonn" },
		code = { "Jevonn" },
	},
}
local scalae = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-Scalae",
	key = "Scalae",
	pos = { x = 3, y = 4 },
	soul_pos = { x = 5, y = 4, extra = { x = 4, y = 4 } },
	immutable = false,
	rarity = "cry_exotic",
	cost = 50,
	atlas = "atlasexotic",
	order = 311,
	config = { extra = { scale = 1, scale_mod = 1, shadow_scale = 1, shadow_scale_mod = 1 } },
	--todo: support jokers that scale multiple variables
	calculate = function(self, card, context)
		--initialize tracking object
		card.ability.extra.scale = to_big(card.ability.extra.scale)
		card.ability.extra.scale_mod = to_big(card.ability.extra.scale_mod)
		card.ability.extra.shadow_scale = to_big(card.ability.extra.shadow_scale)
		card.ability.extra.shadow_scale_mod = to_big(card.ability.extra.shadow_scale_mod)
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
			card.ability.extra.scale = card.ability.extra.scale + card.ability.extra.scale_mod
			card.ability.extra.shadow_scale = card.ability.extra.scale
			card.ability.extra.scale = card.ability.extra.shadow_scale
			card.ability.extra.scale_mod = card.ability.extra.shadow_scale_mod
			return {
				message = localize("k_upgrade_ex"),
				colour = G.C.DARK_EDITION,
			}
		end
		card.ability.extra.scale = card.ability.extra.shadow_scale
		card.ability.extra.scale_mod = card.ability.extra.shadow_scale_mod
		return
	end,
	cry_scale_mod = function(self, card, joker, orig_scale_scale, true_base, orig_scale_base, new_scale_base)
		if joker.ability.name ~= "cry-Scalae" then
			local new_scale = (
				to_big(true_base)
				* (
					(
						1
						+ (
							(to_big(orig_scale_scale) / to_big(true_base))
							^ (to_big(1) / to_big(card.ability.extra.scale))
						)
					) ^ card.ability.extra.scale
				)
			)
			if (new_scale < to_big(1e100)) or not Cryptid.is_card_big(joker) then
				if new_scale >= to_big(1e300) then
					new_scale = 1e300
				else
					new_scale = to_number(new_scale)
				end
			end
			return new_scale
		end
	end,
	loc_vars = function(self, info_queue, card)
		local example = { 2, 3, 4 }
		for i = 1, #example do
			example[i] = to_big(example[i]) ^ (card.ability.extra.scale + 1)
		end
		return {
			vars = {
				number_format(card.ability.extra.scale + 1),
				number_format(card.ability.extra.scale_mod),
				example[1],
				example[2],
				example[3],
			},
		}
	end,
	cry_credits = {
		idea = { "Mathguy" },
		art = { "Mathguy" },
		code = { "Mathguy" },
	},
}
local stella_mortis = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-Stella Mortis",
	key = "stella_mortis",
	config = { extra = { Emult = 1, Emult_mod = 0.4 } },
	pos = { x = 3, y = 5 },
	rarity = "cry_exotic",
	cost = 50,
	order = 502,
	blueprint_compat = true,
	perishable_compat = false,
	atlas = "atlasexotic",
	soul_pos = { x = 5, y = 5, extra = { x = 4, y = 5 } },
	calculate = function(self, card, context)
		if context.ending_shop then
			local destructable_planet = {}
			local quota = 1
			for i = 1, #G.consumeables.cards do
				if
					G.consumeables.cards[i].ability.set == "Planet"
					and not G.consumeables.cards[i].getting_sliced
					and not G.consumeables.cards[i].ability.eternal
				then
					destructable_planet[#destructable_planet + 1] = G.consumeables.cards[i]
				end
			end
			local planet_to_destroy = #destructable_planet > 0
					and pseudorandom_element(destructable_planet, pseudoseed("stella_mortis"))
				or nil

			if planet_to_destroy then
				if Incantation then
					quota = planet_to_destroy:getEvalQty()
				end
				planet_to_destroy.getting_sliced = true
				card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_mod * quota
				G.E_MANAGER:add_event(Event({
					func = function()
						(context.blueprint_card or card):juice_up(0.8, 0.8)
						planet_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
						return true
					end,
				}))
				if not (context.blueprint_card or self).getting_sliced then
					card_eval_status_text((context.blueprint_card or card), "extra", nil, nil, nil, {
						message = localize({
							type = "variable",
							key = "a_powmult",
							vars = {
								number_format(to_big(card.ability.extra.Emult + card.ability.extra.Emult_mod * quota)),
							},
						}),
					})
				end
				return nil, true
			end
		end
		if context.joker_main and (to_big(card.ability.extra.Emult) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_powmult",
					vars = {
						number_format(card.ability.extra.Emult),
					},
				}),
				Emult_mod = card.ability.extra.Emult,
				colour = G.C.DARK_EDITION,
			}
		end
	end,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Emult_mod, center.ability.extra.Emult } }
	end,
	cry_credits = {
		idea = { "SMG9000" },
		art = { "SMG9000", "George the Rat", "patchy", "lolxDdj" },
		code = { "SMG9000" },
	},
}
local circulus_pistoris = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-Circulus Pistoris",
	key = "circulus_pistoris",
	config = { extra = { Emult = math.pi, Echips = math.pi, hands_remaining = 3 } },
	pos = { x = 0, y = 3 },
	rarity = "cry_exotic",
	cost = 10 * math.pi,
	order = 509,
	blueprint_compat = true,
	atlas = "atlasexotic",
	soul_pos = { x = 2, y = 3, extra = { x = 1, y = 3 } },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				Cryptid.safe_get(center, "edition", "cry_oversat") and "tau" or "pi",
				center.ability.extra.hands_remaining,
			},
		}
	end,
	calculate = function(self, card, context)
		if
			context.joker_main
			and (
				G.GAME.current_round.hands_left >= card.ability.extra.hands_remaining
				and G.GAME.current_round.hands_left < card.ability.extra.hands_remaining + 1
			)
		then
			local pi = math.pi
			if Cryptid.safe_get(card, "edition", "cry_oversat") then
				pi = 2 * pi
			end
			return {
				Echip_mod = pi,
				Emult_mod = pi,
				message = localize({
					type = "variable",
					key = "a_powmultchips",
					vars = { (Cryptid.safe_get(card, "edition", "cry_oversat") and "tau" or "pi") },
				}),
				colour = { 0.8, 0.45, 0.85, 1 }, --plasma colors
			}
		end
	end,
	cry_credits = {
		idea = { "SMG9000", "Math" }, --not sure if there's more ppl I'm missing
		art = { "HexaCryonic", "ori" },
		code = { "SMG9000", "Math" },
	},
}
local aequilibrium = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "Ace Aequilibrium",
	key = "equilib",
	config = { extra = { jokers = 2, card = nil } },
	rarity = "cry_exotic",
	pos = { x = 7, y = 0 },
	soul_pos = { x = 6, y = 0, extra = { x = 8, y = 0 } },
	atlas = "atlasexotic",
	cost = 50,
	order = 512,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.negative) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		end
		local joker_generated = "???"
		if G.GAME.aequilibriumkey and G.GAME.aequilibriumkey > 1 then
			joker_generated = localize({
				type = "name_text",
				set = "Joker",
				key = G.P_CENTER_POOLS["Joker"][math.floor(G.GAME.aequilibriumkey or 1) - 1].key,
			})
		end
		return { vars = { math.floor(math.min(25, center.ability.extra.jokers)), joker_generated } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.retrigger_joker then
			for i = 1, math.floor(math.min(25, card.ability.extra.jokers)) do
				local newcard = create_card("Joker", G.jokers, nil, nil, nil, nil, nil)
				newcard:add_to_deck()
				G.jokers:emplace(newcard)
				newcard:set_edition({ negative = true }, true)
			end
			return nil, true
		end
	end,
	--[[
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			if card.ability.extra.card then
				card.ability.extra.card = nil
			end
			card.ability.extra.card =
				Card(G.jokers.T.x, G.jokers.T.y, G.CARD_W * 0.675, G.CARD_H * 0.675, G.P_CARDS.S_A, G.P_CENTERS.c_base)
			--G.hand:emplace(card.ability.extra.card)
			--card.ability.extra.card:set_card_area(G.hand)
			card.ability.extra.card:start_materialize({ G.C.WHITE, G.C.WHITE }, nil, 1.2)
			card.ability.extra.card:set_seal("Gold", true, true)
			card.ability.extra.card:set_edition({ cry_glitched = true }, true)
			--card.ability.extra.card.T.x = card.T.x

			if card.ability.extra.card and G.P_CENTERS.j_blueprint.unlocked then
				local viable_unlockables = {}
				for k, v in ipairs(G.P_LOCKED) do
					if (v.set == "Voucher" or v.set == "Joker") and not v.demo then
						viable_unlockables[#viable_unlockables + 1] = v
					end
				end
				if #viable_unlockables > 0 then
					local card2 = card.ability.extra.card
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 4.04,
						func = function()
							card2 = Card(
								G.jokers.T.x,
								G.jokers.T.y,
								G.CARD_W * 0.675,
								G.CARD_H * 0.675,
								nil,
								pseudorandom_element(viable_unlockables) or self.P_CENTERS.j_joker
							)
							card2.no_ui = #viable_unlockables == 0
							card2.states.visible = false
							card.ability.extra.card.parent = nil
							card.ability.extra.card:start_dissolve({ G.C.BLACK, G.C.ORANGE, G.C.RED, G.C.GOLD })
							return true
						end,
					}))
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 1.04,
						func = function()
							card2:start_materialize()
							--G.:emplace(card)
							return true
						end,
					}))
				end
			end
		end
	end,
	--Known bug: card does not reappear after save reopened
	update = function(self, card, front)
		if card.ability.extra.card then
			if card.ability.extra.card.states and not card.ability.extra.card.states.drag.is then
				card.ability.extra.card.T.x = card.T.x + card.T.w / 5
				card.ability.extra.card.T.y = card.T.y + card.T.h / 5
			end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff and card.ability.extra.card then
			card.ability.extra.card:start_dissolve()
		end
	end,
	]]
	--
	cry_credits = {
		idea = { "Elial2" },
		art = { "Elial2", "unexian", "hydro" },
		code = { "Elial2" },
	},
}
local facile = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-facile",
	key = "facile",
	config = { extra = { Emult = 3, check = 10, check2 = 0 } },
	pos = { x = 6, y = 2 },
	soul_pos = { x = 8, y = 2, extra = { x = 7, y = 2 } },
	rarity = "cry_exotic",
	cost = 50,
	order = 513,
	blueprint_compat = true,
	atlas = "atlasexotic",
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.Emult, center.ability.extra.check },
		}
	end,
	calculate = function(self, card, context)
		if context.individual then
			if context.cardarea == G.play then
				card.ability.extra.check2 = card.ability.extra.check2 + 1
			end
		end
		if context.joker_main and (to_big(card.ability.extra.Emult) > to_big(1)) then
			if card.ability.extra.check2 <= card.ability.extra.check then
				card.ability.extra.check2 = 0
				return {
					message = localize({
						type = "variable",
						key = "a_powmult",
						vars = { number_format(card.ability.extra.Emult) },
					}),
					Emult_mod = card.ability.extra.Emult,
					colour = G.C.DARK_EDITION,
				}
			else
				card.ability.extra.check2 = 0
			end
		end
	end,
	cry_credits = {
		idea = { "Enemui" },
		art = { "Kailen", "hydro" },
		code = { "Jevonn" },
	},
}
local gemino = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-Gemino",
	key = "gemino",
	pos = { x = 6, y = 1 },
	soul_pos = { x = 8, y = 1, extra = { x = 7, y = 1 } },
	immutable = true,
	cry_credits = {
		jolly = {
			"Jolly Open Winner",
			"Requiacity",
		},
		art = { "unexian" },
		code = { "Math" },
	},
	rarity = "cry_exotic",
	blueprint_compat = true,
	cost = 50,
	order = 515,
	atlas = "atlasexotic",
	loc_vars = function(self, info_queue, card)
		card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
		card.ability.blueprint_compat_check = nil
		return {
			main_end = (card.area and card.area == G.jokers) and {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = {
								ref_table = card,
								align = "m",
								colour = G.C.JOKER_GREY,
								r = 0.05,
								padding = 0.06,
								func = "blueprint_compat",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										ref_table = card.ability,
										ref_value = "blueprint_compat_ui",
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.32 * 0.8,
									},
								},
							},
						},
					},
				},
			} or nil,
		}
	end,
	update = function(self, card, front)
		if G.STAGE == G.STAGES.RUN then
			other_joker = G.jokers.cards[1]
			if other_joker and other_joker ~= card and not (Card.no(other_joker, "immutable", true)) then
				card.ability.blueprint_compat = "compatible"
			else
				card.ability.blueprint_compat = "incompatible"
			end
		end
	end,
	calculate = function(self, card2, context)
		if context.end_of_round and not context.repetition and not context.individual then
			local check = false
			local card = G.jokers.cards[1]
			if not Card.no(G.jokers.cards[1], "immutable", true) then
				Cryptid.with_deck_effects(G.jokers.cards[1], function(card)
					Cryptid.misprintize(card, { min = 2, max = 2 }, nil, true)
				end)
				check = true
			end
			if check then
				card_eval_status_text(
					context.blueprint_card or card2,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
			end
			return nil, true
		end
	end,
}
local energia = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-Energia",
	key = "energia",
	pos = { x = 6, y = 3 },
	soul_pos = { x = 8, y = 3, extra = { x = 7, y = 3 } },
	blueprint_compat = false,
	perishable_compat = false,
	order = 514,
	config = { extra = { tags = 1, tag_mod = 1 } },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { math.min(center.ability.extra.tags, 40), center.ability.extra.tag_mod },
		}
	end,
	rarity = "cry_exotic",
	cost = 50,
	atlas = "atlasexotic",
	calculate = function(self, card, context)
		if context.cry_add_tag then
			local value = #G.GAME.tags or 0
			local t = math.min(40 - value, card.ability.extra.tags)
			card.ability.extra.tags = card.ability.extra.tags + card.ability.extra.tag_mod
			if t > 0 then
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize({
						type = "variable",
						key = card.ability.extra.tags == 1 and "a_tag" or "a_tags",
						vars = { t },
					})[1],
					colour = G.C.DARK_EDITION,
				})
			end
			return { tags = math.max(t, 0) }
		end
	end,
	cry_credits = {
		idea = { "jenwalter666" },
		art = { "unexian" },
		code = { "Math" },
	},
}
--why is this an exotic???
local verisimile = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-verisimile",
	key = "verisimile",
	pos = { x = 0, y = 1 },
	soul_pos = { x = 1, y = 1, extra = { x = 2, y = 1 } },
	config = { extra = { xmult = 1 } },
	rarity = "cry_exotic",
	cost = 50,
	order = 516,
	immutable = true,
	blueprint_compat = true,
	atlas = "placeholders",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.post_trigger and not context.blueprint then
			--Todo: Gros Michel, Cavendish, Planet.lua
			--Bus driver is ignored because it always triggers anyway
			if
				context.other_joker.ability.name == "8 Ball"
				or context.other_joker.ability.name == "Space Joker"
				or context.other_joker.ability.name == "Business Card"
				or context.other_joker.ability.name == "Hallucination"
			then
				local variable = context.other_joker
				card.ability.extra.xmult = card.ability.extra.xmult + variable.ability.extra
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } }) }
				)
			elseif
				context.other_joker.ability.name == "Reserved Parking"
				or context.other_joker.ability.name == "Bloodstone"
				or context.other_joker.ability.name == "cry-Googol Play Card"
				or context.other_joker.ability.name == "cry-Boredom"
				or context.other_joker.ability.name == "cry-bonusjoker"
				or context.other_joker.ability.name == "cry-multjoker"
				or context.other_joker.ability.name == "cry-scrabble"
			then
				local variable = context.other_joker
				card.ability.extra.xmult = card.ability.extra.xmult + variable.ability.extra.odds
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } }) }
				)
			elseif context.other_joker.ability.name == "cry-notebook" then
				--This also triggers at notebook's end of round which isn't intentional but i'm not bothered enough about this to find a workaround
				local variable = context.other_joker
				card.ability.extra.xmult = card.ability.extra.xmult + variable.ability.extra.odds
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } }) }
				)
			end
			return nil, true
		elseif context.consumeable and not context.blueprint then
			if context.consumeable.ability.name == "The Wheel of Fortune" and context.consumeable.cry_wheel_success then
				local variable = context.consumeable
				card.ability.extra.xmult = card.ability.extra.xmult + variable.ability.extra --Doesn't account for misprintizing for some reason
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } }) }
				)
			end
		elseif context.joker_main and (to_big(card.ability.extra.xmult) > to_big(1)) then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } }),
				Xmult_mod = card.ability.extra.xmult,
			}
		end
	end,
	cry_credits = {
		idea = { "Enemui" },
		code = { "Jevonn" },
	},
}
local duplicare = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
		},
	},
	object_type = "Joker",
	name = "cry-duplicare",
	key = "duplicare",
	config = { extra = { Xmult = 1, Xmult_mod = 1 } },
	pos = { x = 0, y = 6 },
	soul_pos = { x = 2, y = 6, extra = { x = 1, y = 6 } },
	rarity = "cry_exotic",
	cost = 50,
	order = 517,
	blueprint_compat = true,
	atlas = "atlasexotic",
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.Xmult, center.ability.extra.Xmult_mod },
		}
	end,
	calculate = function(self, card, context)
		if
			not context.blueprint
			and (
				(context.post_trigger and context.other_joker ~= card)
				or (context.individual and context.cardarea == G.play)
			)
		then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
			card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_upgrade_ex") })
		end
		if context.joker_main and (to_big(card.ability.extra.Xmult) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = {
						number_format(card.ability.extra.Xmult),
					},
				}),
				Xmult_mod = card.ability.extra.Xmult,
				colour = G.C.MULT,
			}
		end
	end,
	cry_credits = {
		idea = { "Enemui" },
		art = { "Shellular" },
		code = { "elial2" },
	},
}
-- to be honest, this needs a refactor because
-- rescribed jokers are forgotten on save reload
-- they are not saved in a good way right now
-- status text is not handled properly
local rescribere = {
	object_type = "Joker",
	name = "cry-Rescribere",
	key = "rescribere",
	pos = { x = 0, y = 1 },
	soul_pos = { x = 1, y = 1, extra = { x = 2, y = 1 } },
	blueprint_compat = false,
	perishable_compat = false,
	rarity = "cry_exotic",
	cost = 50,
	order = 69420,
	atlas = "placeholders",
	calculate = function(self, card, context)
		local eligibleJokers = {}
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].ability.name ~= card.ability.name then
				eligibleJokers[#eligibleJokers + 1] = G.jokers.cards[i]
			end
		end

		for i = 1, #eligibleJokers do
			if
				context.selling_card
				and context.card.ability.name ~= card.ability.name
				and context.card ~= eligibleJokers[i]
			then
				local oldfunc = eligibleJokers[i].calculate_joker

				eligibleJokers[i].ability.rescribere_jokers = eligibleJokers[i].ability.rescribere_jokers or {}
				eligibleJokers[i].ability.rescribere_jokers[#eligibleJokers[i].ability.rescribere_jokers + 1] =
					context.card

				eligibleJokers[i].calculate_joker = function(cardd, contextt)
					local totalret = oldfunc(cardd, contextt)

					v = eligibleJokers[i].ability.rescribere_jokers[#eligibleJokers[i].ability.rescribere_jokers]

					local ret = v:calculate_joker(contextt)
					if ret and type(ret) == "table" then
						totalret = totalret or { message = "Copying", card = eligibleJokers[i] }
						for _i, _v in pairs(ret) do
							if not totalret[_i] then
								totalret[_i] = ret[_i] or _v
								--print(totalret[_i] .. "--------------")
							else
								if type(totalret[_i]) == "number" then
									totalret[_i] = totalret[_i] + ret[_i]
								end
							end
						end
						totalret.card = eligibleJokers[i]
					end
					return totalret
				end
			end
		end
	end,
}
local formidiulosus = {
	dependencies = {
		items = {
			"c_cry_gateway",
			"set_cry_exotic",
			"set_cry_spooky",
		},
	},
	object_type = "Joker",
	name = "cry-Formidiulosus",
	key = "formidiulosus",
	pos = { x = 6, y = 4 },
	soul_pos = { x = 8, y = 4, extra = { x = 7, y = 4 } },
	blueprint_compat = true,
	config = { extra = { candy = 3, Emult_mod = 0.01, Emult = 1 } },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { 3, center.ability.extra.Emult_mod, center.ability.extra.Emult },
		}
	end,
	rarity = "cry_exotic",
	cost = 50,
	order = 518,
	atlas = "atlasexotic",
	no_dbl = true,
	update = function(self, card, front)
		card.ability.extra.Emult = 1
			+ (card.ability.extra.Emult_mod * #Cryptid.advanced_find_joker(nil, "cry_candy", nil, nil, true))
	end,
	calculate = function(self, card, context)
		if
			(context.buying_card or context.cry_creating_card)
			and context.card.ability.set == "Joker"
			and context.card.config.center.rarity == "cry_cursed"
			and not context.blueprint
			and not (context.card == card)
		then
			G.E_MANAGER:add_event(Event({
				func = function()
					context.card:start_dissolve()
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize("k_nope_ex"),
						colour = G.C.BLACK,
					})
					return true
				end,
			}))
		end
		if context.ending_shop then
			for i = 1, 3 do
				local card = create_card("Joker", G.jokers, nil, "cry_candy", nil, nil, nil, "cry_trick_candy")
				card:set_edition({ negative = true }, true)
				card:add_to_deck()
				G.jokers:emplace(card)
			end
		end
		if context.cardarea == G.jokers and (to_big(card.ability.extra.Emult) > to_big(1)) and context.joker_main then
			return {
				message = localize({
					type = "variable",
					key = "a_powmult",
					vars = {
						number_format(card.ability.extra.Emult),
					},
				}),
				Emult_mod = card.ability.extra.Emult,
				colour = G.C.DARK_EDITION,
			}
		end
	end,
	cry_credits = {
		idea = { "HexaCryonic", "Kailen" },
		art = { "Foegro", "hydro" },
		code = { "Foegro" },
	},
}
local items = {
	gateway,
	iterum,
	universum,
	exponentia,
	speculo,
	redeo,
	tenebris,
	effarcire,
	effarcire_sprite,
	crustulum,
	primus,
	scalae,
	stella_mortis,
	circulus_pistoris,
	aequilibrium,
	facile,
	gemino,
	energia,
	--verisimile, WHY IS THIS AN EXOTIC????????????????????
	--rescribere, [NEEDS REFACTOR]
	duplicare,
	formidiulosus,
}
return {
	name = "Exotic Jokers",
	init = function()
		--I have no clue what this patch does
		local cc = copy_card
		function copy_card(card, a, b, c, d)
			local m
			if
				card
				and card.ability
				and card.ability.extra
				and type(card.ability.extra) == "table"
				and card.ability.extra.card
			then
				m = card.ability.extra.card
				card.ability.extra.card = nil
			end
			local ret = cc(card, a, b, c, d)
			if
				card
				and card.ability
				and card.ability.extra
				and type(card.ability.extra) == "table"
				and card.ability.extra.card
				and m
			then
				card.ability.extra.card = m
			end
			return ret
		end
	end,
	items = items,
}
