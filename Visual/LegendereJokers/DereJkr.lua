--- STEAMODDED HEADER
--- MOD_NAME: Legendere Jokers
--- MOD_ID: DereJkr
--- MOD_AUTHOR: [eaze]
--- MOD_DESCRIPTION: turns the 5 legendary jokers into anime girls

----------------------------------------------
------------MOD CODE -------------------------

function SMODS.INIT.DereJkr()

    jokers = {
        j_caino = { pos = 0 },
        j_triboulet = { pos = 1 },
        j_yorick = { pos = 2 },
        j_chicot = { pos = 3 },
        j_perkeo = { pos = 4 }
    }

    SMODS.Atlas {
            key = "Jokers-Legendere",
            path = "Jokers-Legendere.png",
            px = 71,
            py = 95
    }

    for jkr,data in pairs(jokers) do
        SMODS["Joker"]:take_ownership(jkr, { atlas = "Jokers-Legendere", 
            pos = { x = 0 + data.pos, y = 0 },
            soul_pos = { x = 0 + data.pos, y = 1 }}, true)
    end

end

----------------------------------------------
------------MOD CODE END----------------------