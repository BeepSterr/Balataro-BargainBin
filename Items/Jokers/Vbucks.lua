SMODS.Joker {
	key = 'vbucks',
	rarity = 1,
	atlas = 'Jokers',
	blueprint_compat = false,
	pos = { x = 1, y = 0 },
	cost = 0,
    config = { extra = { cost = 8.99, chips = 1000 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cost, card.ability.extra.chips } }
    end,
	calculate = function(self, card, context)

        if context.joker_main and not context.blueprint then

            if G.GAME.dollars > card.ability.extra.cost then
                card.ability.extra.cost(-card.ability.extra.cost)
                return {
                    chip_mod = card.ability.extra.chips,
                }
            else
                return
            end

        end

	end
}