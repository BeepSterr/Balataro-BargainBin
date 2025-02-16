local deck = {}
local suits = {"H", "D", "C", "S"}
for i = 1, #suits do
    for j = 0, 7 do
        table.insert(deck, { s = suits[i], r = "A" })
    end
end

SMODS.Challenge{
    key = "overflow_challenge",
    loc_txt = {
        name = "overflow_challenge",
    },
    rules = {
        modifiers = {
            --{
            --    id = "joker_slots",
            --    value = 2,
            --}
        }
    },
    jokers = {
        { id = "j_beepsterr_bargainbin_overflow", eternal = true, pinned = true, edition = "negative" }
    },
    restrictions = {
        banned_cards = {
        	{ id = "k_standard_pack" },
        },
        banned_tags = {
            { id = "tag_standard" },
        }
    },
    deck = {
        type = "Challenge Deck",
        cards = deck
    }
}
