SMODS.Challenge{
    key = "pure_chance",
    loc_txt = {
        name = "pure_chance",
    },
    rules = {
        custom = {
            { id = "no_shop_jokers" },
            { id = "no_extra_hand_money", value = true },
            { id = "no_interest", value = true },
            { id = "no_reward", value = true },
            --{ id = "no_reward_specific", value = true },
        },
        modifiers = {
            {
                id = "joker_slots",
                value = 3,
            }
        }
    },
    jokers = {
        { id = "j_beepsterr_bargainbin_slotmachine", eternal = true },
        { id = "j_beepsterr_bargainbin_slotmachine", eternal = true },
        { id = "j_beepsterr_bargainbin_slotmachine", eternal = true }
    },
    restrictions = {
        banned_cards = {
            { id = "v_seed_money" },
            { id = "v_money_tree" },
            {id = 'c_judgement'},
            {id = 'c_wraith'},
            {id = 'c_soul'},
            {id = 'v_antimatter'},
            {id = 'p_buffoon_normal_1', ids = {
                'p_buffoon_normal_1','p_buffoon_normal_2','p_buffoon_jumbo_1','p_buffoon_mega_1',
            }},
        },
        banned_tags = {
            {id = 'tag_rare'},
            {id = 'tag_uncommon'},
            {id = 'tag_holo'},
            {id = 'tag_polychrome'},
            {id = 'tag_negative'},
            {id = 'tag_foil'},
            {id = 'tag_buffoon'},
            {id = 'tag_top_up'},
        },
        banned_other = {
            {id = 'bl_final_acorn', type = 'blind'},
            {id = 'bl_final_heart', type = 'blind'},
            {id = 'bl_final_leaf', type = 'blind'}
        }
    },
    deck = {
        type = "Challenge Deck",
    }
}
