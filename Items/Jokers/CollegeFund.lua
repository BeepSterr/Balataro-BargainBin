SMODS.Joker {
	key = 'college_fund',
	loc_txt = {
		name = 'College Fund',
		text = {
			"When blind is selected {C:attention}-$#1#{}",
			"and add {C:attention}$#2#{} to sell value",
		}
	},
	rarity = 2,
	atlas = 'Jokers',
	blueprint_compat = false,
	pos = { x = 3, y = 0 },
	cost = 6,
    config = { extra = { cost = 5, increment_amount = 6 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cost, card.ability.extra.increment_amount } }
    end,
	calculate = function(self, card, context)

        if context.setting_blind and not context.blueprint then

            if G.GAME.dollars >= card.ability.extra.cost then
                ease_dollars(-card.ability.extra.cost)
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.increment_amount
                card:set_cost();

                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "$" .. card.ability.extra.increment_amount})
                return {
                    message = "+$" .. card.ability.extra.increment_amount .. " saved!",
                    colour = G.C.MONEY,
                    card = card
                }

            else
                return {
                    message = "Broke!",
                    colour = G.C.JOKER_GREY,
                    card = card
                }
            end

        end

	end
}
