
local slotmachine = {}
slotmachine.options = {
    { key = "Hearts",       atlas = { x = 0}, scoring = { suit = "Hearts"}},
    { key = "Clubs",        atlas = { x = 1}, scoring = { suit = "Clubs"}},
    { key = "Spades",       atlas = { x = 2}, scoring = { suit = "Spades"}},
    { key = "Diamonds",     atlas = { x = 3}, scoring = { suit = "Diamonds"}},

    { key = "Ace",          atlas = { x = 4}, scoring = { rank = "14"}},
    { key = "King",         atlas = { x = 5}, scoring = { rank = "13"}},
    { key = "Queen",        atlas = { x = 6}, scoring = { rank = "12"}},
    { key = "Jack",         atlas = { x = 7}, scoring = { rank = "11"}},

    { key = "10",           atlas = { x = 8}, scoring = { rank = "10"}},
    { key = "9",            atlas = { x = 9}, scoring = { rank = "9"}},
    { key = "8",            atlas = { x = 10}, scoring = { rank = "8"}},
    { key = "7",            atlas = { x = 11}, scoring = { rank = "7"}},

    { key = "6",            atlas = { x = 12}, scoring = { rank = "6"}},
    { key = "5",            atlas = { x = 13}, scoring = { rank = "5"}},
    { key = "4",            atlas = { x = 14}, scoring = { rank = "4"}},
    { key = "3",            atlas = { x = 15}, scoring = { rank = "3"}},

    { key = "2",            atlas = { x = 16}, scoring = { rank = "2"}},
    { key = "face",         atlas = { x = 17}, scoring = { any_face = true}},
    { key = "numbered",     atlas = { x = 18}, scoring = { any_rank = true}},
}

SMODS.Atlas {
	key = "Slots",
	path = "slot_machine_options.png",
	px = 71,
	py = 95
}

SMODS.Joker {
	key = 'slotmachine',
	rarity = 3,
	blueprint_compat = false,
	atlas = 'Jokers',
	pos = { x = 5, y = 1 },
	cost = 0,
	blueprint_compat = true,
    config = {
        re_rollable = true,
        layers = {
            slot_1 = { atlas = { key = "beepsterr_bargainbin_Slots", x = 1, y = 0 }, },
            slot_2 = { atlas = { key = "beepsterr_bargainbin_Slots", x = 4, y = 1 }, },
            slot_3 = { atlas = { key = "beepsterr_bargainbin_Slots", x = 18, y = 2 }, },
        },
        extra = {

            rolling_state = -10,
            slot_1_value = slotmachine.options[14],
            slot_2_value = slotmachine.options[15],
            slot_3_value = slotmachine.options[16],
            stored_cash = 0
        }
    },
    loc_vars = function(self, info_queue, card)

        info_queue[#info_queue+1] = {set = "Other", key = "slotmachine_rewards", specific_vars = {}}
        info_queue[#info_queue+1] = {set = "Other", key = "slotmachine_jackpot", specific_vars = {}}

        return {
            vars = {
                card.ability.extra.update,
                card.ability.extra.cost,
                card.ability.extra.chips
            }
        }
    end,

    reroll = function(self, card, instant)

        if not card.ability.layers then return end

        card.ability.extra.rolling_state = 0

        for k,v in pairs(card.ability.layers) do

             -- Flip the card back
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = instant and 0 or 1,
                func = function()

                    card.ability.extra.rolling_state = card.ability.extra.rolling_state + 1
                    card.ability.extra[k.."_value"] = pseudorandom("slotmachine_rolls", 1, #slotmachine.options)
                    play_sound('tarot2', percent);
                    card:juice_up(0.3, 0.3);
                    return true
                end
            }))
        end

         -- Jackpot! (= event because it would trigger before rolling was complete)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.1,
            func = function()
                if card.ability.extra.slot_1_value == card.ability.extra.slot_2_value and card.ability.extra.slot_2_value == card.ability.extra.slot_3_value then
                    ease_dollars(100)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Jackpot!", colour = G.C.MONEY})
                    play_sound('gold_seal', percent);
                end
                return true
            end
        }))


    end,

    update = function(self, card)
        if not card.ability.layers then return end

        local is_rolling = 0
        for k,v in pairs(card.ability.layers) do
            is_rolling = is_rolling + 1
            if card.ability.extra.rolling_state < is_rolling then
                card.ability.layers[k].atlas.x = pseudorandom_element(slotmachine.options, pseudoseed('slotmachine_rolls_visual')).atlas.x
            else
                card.ability.layers[k].atlas.x = slotmachine.options[card.ability.extra[k.."_value"]].atlas.x
            end
        end
    end,
	calculate = function(self, card, context)

        -- Reroll
        if context.setting_blind and not context.blueprint then
            self.reroll(self, card)
            return
        end

        -- If joker somehow gets created mid-round (Judgement, Ankh) quickly roll the slots to prevent crash!
        if card.ability.extra.rolling_state == -10 then
            self.reroll(self, card, true)
        end

        -- grant stored cash
        if context.end_of_round and context.cardarea == G.jokers then
            if card.ability.extra.stored_cash > 0 then
                ease_dollars(card.ability.extra.stored_cash)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Won $" .. card.ability.extra.stored_cash, colour = G.C.MONEY})
                card.ability.extra.stored_cash = 0
            end
            return
        end

        -- Score cards
        if context.individual and context.cardarea == G.play then

            local card_score = 0

            for k,v in pairs(card.ability.layers) do

                local slot_value = slotmachine.options[card.ability.extra[k.."_value"]]

                -- Sorry stone cards...
                if context.other_card and context.other_card.config.center == G.P_CENTERS.m_stone then return end

                -- Check for specific suit
                if slot_value.scoring.suit and (context.other_card:is_suit(slot_value.scoring.suit)) then
                    card_score = card_score + 1

                -- Check for specific rank
                elseif slot_value.scoring.rank and slot_value.scoring.rank == tostring(context.other_card:get_id()) then
                    card_score = card_score + 1

                -- Check for "any face card"
                elseif slot_value.scoring.any_face and context.other_card:is_face() then
                    card_score = card_score + 1

                -- Check for "any number card"
                elseif slot_value.scoring.any_rank and not context.other_card:is_face() and tostring(context.other_card:get_id()) ~= "14" then
                    card_score = card_score + 1
                end

            end

            -- nothing matched, boo womp.
            if card_score == 0 then return end

            card:juice_up(card_score * 0.3, card_score * 0.3);
            context.other_card:juice_up(card_score * 0.3, card_score * 0.3);

            -- One tile match
            if card_score == 1 then
                card.ability.extra.stored_cash = card.ability.extra.stored_cash + 1
                return {
                    message = "Hit!",
                    chips = 100
                 }
            end
            if card_score == 2 then
                card.ability.extra.stored_cash = card.ability.extra.stored_cash + 5
                return {
                    message = "Double Hit!",
                    mult = 10
                 } end
            if card_score == 3 then
                card.ability.extra.stored_cash = card.ability.extra.stored_cash + 10
                return {
                    message = "Tripple Hit!",
                    x_mult = 2,
                    x_chips = 2
                }
            end


        end

	end
}