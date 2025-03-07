


local function init()
    local loc_text = {
        name = "Gamblin' Man",
            text = {
                "Multiply money gain by ",
                "a random number between {C:attention}#1# {}and {C:attention}#2#.{}"
            }
    }
    

    local GamblinMan = SMODS.Joker:new(
        "Gamblin Man",
        tpmakeID("gamblin_man"),
        {
            extra = {
                min = -0.5,
                max = 2
            }
        },
        {
            x = 0,
            y = 0
        },
        loc_text,
        1,
        0,
        true,
        true,
        false,
        true,
        "Gamblin Man"
        
    )
    
    Tetrapak.Jokers["j_" .. tpmakeID("gamblin_man")] = GamblinMan
    
    
end

local function load_effect()
    local original_ease_dollars = ease_dollars

    -- based on Fiendish Joker from Bunco

    function ease_dollars(mod, instant)

        if G.jokers ~= nil then
            for _, v in ipairs(G.jokers.cards) do
                if v.ability.name == "Gamblin Man" and not v.debuff and mod > 0 then
                    local mult = pseudorandom("gamblin_man") -- 0 - 1
                    mult = v.ability.extra.min + mult * (v.ability.extra.max - v.ability.extra.min)

                    -- round to 0.25
                    mult = math.floor(mult * 4 + 0.5) / 4


                    mod = math.ceil(mod * mult)
                    v:juice_up(1.0,0.5)
                    card_eval_status_text(v, 'extra', nil, nil, nil, {message = tostring(mult) .. 'x'}); 
                   
                end
            end
        end

        original_ease_dollars(mod, instant)
    end

    SMODS.Jokers[tpjokerSlug("gamblin_man")].loc_def =function (card)
        
        return {
            card.ability.extra.min,
            card.ability.extra.max
        }
    end
    
end

return {
    init = init,
    load_effect = load_effect
}