SMODS.Joker {
	key = 'timeout',
	rarity = 3,
	atlas = 'Jokers',
	blueprint_compat = true,
	eternal_compat = true,
	pos = { x = 5, y = 0 },
	cost = 6,
    config = { extra = { current_chips = 300, chips_lost_per_second = 1, chips_per_blind = 60, timestamp = nil, inactive = false } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.current_chips, card.ability.extra.chips_lost_per_second, card.ability.extra.chips_per_blind, card.ability.extra.timestamp, card.ability.extra.inactive } }
    end,
    update = function(self, card)

        -- Boo Womp. Card is dead.
        if card.ability.extra.current_chips <= 0 and not card.ability.extra.inactive then
            card.ability.extra.inactive = true
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Too Slow!", colour = G.C.PERISHABLE})
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    -- This part destroys the card.
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            G.jokers:remove_card(card)
                            card:remove()
                            card = nil
                            return true;
                        end
                    }))
                    return true
                end
            }))
            return true;
        end

        if card.ability.extra.timestamp == nil then
            card.ability.extra.timestamp = os.time()
        end

        local previous_timestamp = card.ability.extra.timestamp
        local current_timestamp = os.time()
        local time_difference = current_timestamp - previous_timestamp

        -- A Second has passed
        if(time_difference > 0) then

           -- set new timestamp
          card.ability.extra.timestamp = current_timestamp
          card.ability.extra.current_chips = card.ability.extra.current_chips - card.ability.extra.chips_lost_per_second

          if(card.ability.extra.current_chips == 60) then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "60 Seconds!", colour = G.C.PERISHABLE})
          end
          if(card.ability.extra.current_chips == 30) then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "30 Seconds!", colour = G.C.PERISHABLE})
          end
          if(card.ability.extra.current_chips == 10) then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "10!", colour = G.C.PERISHABLE})
          end
          if(card.ability.extra.current_chips == 5) then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "5!", colour = G.C.PERISHABLE})
          end
          if(card.ability.extra.current_chips == 4) then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "4!", colour = G.C.PERISHABLE})
          end
          if(card.ability.extra.current_chips == 3) then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "3!", colour = G.C.PERISHABLE})
          end
          if(card.ability.extra.current_chips == 2) then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "2!", colour = G.C.PERISHABLE})
          end
          if(card.ability.extra.current_chips == 1) then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "1!", colour = G.C.PERISHABLE})
          end

        end

    end,
    calculate = function(self, card, context)

        if context.setting_blind and not context.blueprint then
            card.ability.extra.current_chips = card.ability.extra.current_chips + card.ability.extra.chips_per_blind
            return {
                message = "Time Added",
                colour = G.C.CHIPS,
            }
        end

        if context.joker_main then
            return {
                message = "+" .. card.ability.extra.current_chips,
                colour = G.C.CHIPS,
                chip_mod = card.ability.extra.current_chips,
            }
        end

	end
}

-- Music override on Timeout joker
SMODS.Sound {
    key = "timeout_music",
    path = "timeout.ogg",
    pitch = 1.0,
    volume = 1.0,
	select_music_track = function()
	    if beepsterr.bargainbin.config.music_enabled and next(SMODS.find_card("j_beepsterr_bargainbin_timeout")) then
            return 2e512
        end
        return false
	end,
}
