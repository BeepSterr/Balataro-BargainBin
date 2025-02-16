SMODS.Challenge{
    key = "timer_challenge",
    loc_txt = {
        name = "timer_challenge",
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
        { id = "j_beepsterr_bargainbin_timeout", eternal = true, pinned = true, edition = "negative" }
    },
    restrictions = {
        banned_cards = {
        	{ id = "j_mr_bones" },
            { id = "v_hieroglyph" },
            { id = "v_petroglyph" },
        },
        banned_tags = {
            { id = "tag_negative" },
            { id = "tag_coupon" },
            { id = "tag_top_up" }
        }
    },
    deck = {
        type = "Challenge Deck"
    }
}
