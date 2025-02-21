SMODS.Joker {
	key = 'guest_pass',
	rarity = 2,
	atlas = 'Jokers',
	blueprint_compat = true,
	pos = { x = 4, y = 0 },
	cost = 6,
    config = { extra = { increment_amount = 1, current_mult = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.increment_amount, card.ability.extra.current_mult } }
    end,
    calculate = function(self, card, context)

        if context.joker_main then

            -- keep track if mult was increased or decreased
            local mult_delta = 0;

            for i = 1, #context.scoring_hand do
                local scored_card = context.scoring_hand[i]

                -- Card cannot be a stone card or numbered card
                if scored_card.config.center ~= G.P_CENTERS.m_stone then
                    -- Grant + mult on face card, - mult on numbered card
                    if scored_card:is_face() then
                        card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.increment_amount
                        mult_delta = mult_delta + card.ability.extra.increment_amount
                    else
                        mult_delta = mult_delta - card.ability.extra.increment_amount
                        card.ability.extra.current_mult = card.ability.extra.current_mult - card.ability.extra.increment_amount
                    end
                end

            end

            if mult_delta > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')}); return true
                    end
                }))
            end

            -- no case for 0 mult change because we don't need to display that

            -- Reset mult if it goes below 0
            if card.ability.extra.current_mult < 0 then
                card.ability.extra.current_mult = 0
            end

            if card.ability.extra.current_mult > 0 then

                return {
                    mult_mod = card.ability.extra.current_mult,
                    colour = G.C.MULT,
                }

            end

        end
	end
}
