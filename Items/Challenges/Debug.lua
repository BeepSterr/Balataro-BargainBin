if beepsterr.bargainbin.debug then
    SMODS.Challenge{
        key = "debug",
        loc_txt = {
            name = "debug",
        },
        --rules = {
        --    modifiers = {
        --        {
        --            id = "joker_slots",
        --            value = 2,
        --        }
        --    }
        --},
        jokers = {
            --{ id = "j_beepsterr_bargainbin_izanagis" },
            --{ id = "j_burglar" },
            --{ id = 'j_troubadour' },
            --{ id = 'j_drunkard' },
            { id = 'j_beepsterr_bargainbin_nightguard' },
        },
        deck = {
            type = "Challenge Deck"
        }
    }
end