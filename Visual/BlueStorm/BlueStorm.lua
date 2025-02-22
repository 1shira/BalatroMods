--- STEAMODDED HEADER
--- MOD_NAME: Yuri Blueprint Brainstorm 
--- MOD_ID: DereBS
--- MOD_AUTHOR: [eaze]
--- MOD_DESCRIPTION: turns Blueprint & Brainstorm into cute yuri couple

----------------------------------------------
------------MOD CODE -------------------------

function SMODS.INIT.DereBS()

    jokers = {
        j_blueprint = { pos = 0 },
        j_brainstorm = { pos = 1 }
    }

    SMODS.Atlas {
            key = "BlueStorm",
            path = "BlueStorm.png",
            px = 71,
            py = 95
    }

    for jkr,data in pairs(jokers) do
        SMODS["Joker"]:take_ownership(jkr, { atlas = "BlueStorm", 
            pos = { x = 0 + data.pos, y = 0 },
            soul_pos = { x = 0 + data.pos, y = 1 }}, true)
    end

end

----------------------------------------------
------------MOD CODE END----------------------