SMODS.Joker {
	key = 'izanagis',
	rarity = 3,
	atlas = 'Jokers',
	blueprint_compat = true,
	pos = { x = 0, y = 1 },
	cost = 0,
    config = { extra = { x_mult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end,
	calculate = function(self, card, context)

	    local function consumeHandsAndDiscards()

	        print("Consuming hands and discards")

            local hands_left = G.GAME.current_round.hands_left;
            local discards_left = G.GAME.current_round.discards_left;
            local previous_xmult = card.ability.extra.x_mult;

            -- Modify multiplier
            card.ability.extra.x_mult = previous_xmult + (hands_left-1) + discards_left;

            -- Remove all discards
            ease_discard(-G.GAME.current_round.discards_left, nil, true)

            -- Remove all but 1 hand
            ease_hands_played(-G.GAME.current_round.hands_left + 1, true)

            -- Announce changes
            if previous_xmult ~= card.ability.extra.x_mult then
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Honed Edge", colour = G.C.GOLD })
            end

	    end

	    local function checkGameState()
	        local valid_states = {
	            G.STATES.SELECTING_HAND,
	            G.STATES.HAND_PLAYED,
	            G.STATES.DRAW_TO_HAND,
	            G.STATES.BLIND_SELECT,
	            -- G.STATES.ROUND_EVAL -- not needed, this is end of round screen
	        }
            for i, state in ipairs(valid_states) do
                if G.STATE == state then
                    return true
                end
            end
            return false
	    end


        -- On blind selection, consume hands and discards
        if context.setting_blind and not context.blueprint then
            consumeHandsAndDiscards();
        end

        -- Workaround for "Burglar" and other +hand effects
        if context.hand_count_changed and checkGameState() and G.GAME.current_round.hands_left > 1 then
            consumeHandsAndDiscards();
        end

        -- Workaround for "Drunkard" and other +discard effects
        if context.discard_count_changed and checkGameState() and G.GAME.current_round.discards_left > 1 then
            consumeHandsAndDiscards();
        end

        if context.joker_main then
            return {
                message = "x" .. card.ability.extra.x_mult,
                Xmult_mod = card.ability.extra.x_mult
            }
        end

        if context.end_of_round and context.cardarea == G.jokers then
            card.ability.extra.x_mult = 1
            G.GAME.current_round.force_single_hand = false
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Reset", colour = G.C.GOLD })
        end

	end
}