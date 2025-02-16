SMODS.Joker {
	key = 'overflow',
	loc_txt = {
		name = 'Overflow',
		text = {
			"Increase {C:attention}rank{} of",
			"all scored cards"
		}
	},
	config = {},
	rarity = 1,
	atlas = 'Jokers',
	blueprint_compat = true,
	pos = { x = 0, y = 0 },
	cost = 4,
	calculate = function(self, card, context)

        if context.joker_main then

            -- Process all scored cards
            for i = 1, #context.scoring_hand do

                card_eval_status_text(context.scoring_hand[i], 'extra', nil, nil, nil, {message = "Upgrade!"})
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.3,
                    func = function()

                        local scored_card = context.scoring_hand[i]
                        if(scored_card.config.center == G.P_CENTERS.m_stone) then return true end

                        local new_rank = tostring(scored_card:get_id() + 1)
                        if new_rank == "15" then
                            new_rank = "2"
                        end

                        if new_rank == "11" then new_rank = "Jack"
                        elseif new_rank == "12" then new_rank = "Queen"
                        elseif new_rank == "13" then new_rank = "King"
                        elseif new_rank == "14" then new_rank = "Ace" end

                        -- effects :3
                        local percent = 1.15 - (i-0.999)/(#context.scoring_hand-0.998)*0.3

                        scored_card:flip();
                        play_sound('card1', percent);
                        card:juice_up(0.3, 0.3);

                        -- Flip the card back
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            blockable = false,
                            delay = 0.2,
                            func = function()
                                SMODS.change_base(scored_card, nil, new_rank)
                                play_sound('card1', percent);
                                scored_card:flip();
                                scored_card:juice_up(0.3, 0.3);
                                return true
                            end
                        }))
                        return true

                    end
                }))

            end

            return
        end

	end
}
