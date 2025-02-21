-- jonkler is broken and i dont wanna fix it right now so into the void it goes

--[[
SMODS.Joker {
	key = 'blink_twice',
	rarity = 2,
	cost = 4,
	atlas = 'Jokers',
	blueprint_compat = true,
	pos = { x = 1, y = 1 },
    config = { extra = { increment_amount = 1, current_mult = 0, current_cards = {} } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.increment_amount, card.ability.extra.current_mult } }
    end,
    calculate = function(self, card, context)

        -- TODO: Check doesn't actually work...
        -- Need to fix this joker!

        if context.blueprint then return end

        -- Store cards
        if context.joker_main then

            card.ability.extra.current_cards = {}
            for i = 1, #context.scoring_hand do
                local scored_card = context.scoring_hand[i]
                table.insert(card.ability.extra.current_cards, scored_card)
            end

        end

        -- grant x_mult
       if context.after and context.individual and context.cardarea == G.play then

            -- loop over all scored cards and check if they exist inside current_cards
            -- if not add 1 to x_mult

            local x_mult = 0;

            for i = 1, #context.scoring_hand do
                local scored_card = context.scoring_hand[i]
                local found = false;
                for j = 1, #card.ability.extra.current_cards do
                    if scored_card == card.ability.extra.current_cards[j] then
                        found = true;
                        break;
                    end
                end
                if not found then
                    x_mult = x_mult + 1;
                end
            end

            if x_mult > 0 then
                return {
                    x_mult = x_mult,
                }
            end

            return
        end

	end
}--]]
