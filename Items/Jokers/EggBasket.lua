SMODS.Joker {
	key = 'egg_basket',
	rarity = 2,
	atlas = 'Jokers',
	blueprint_compat = false,
	pos = { x = 2, y = 0 },
	cost = 6,
	calculate = function(self, card, context)

        if context.joker_main and not context.blueprint then

            local played_hand = G.GAME.hands[context.scoring_name];
            local available_hands = {}

            for hand_name ,hand in pairs(G.GAME.hands) do
                if hand.visible and hand.level > 1 and hand_name ~= context.scoring_name then
                    table.insert(available_hands, hand_name)
                end
            end

            local picked_hand = pseudorandom_element(available_hands, pseudoseed('nihility'))
            if not picked_hand then
                return {
                    message = "Nope!",
                    colour = G.C.JOKER_GREY,
                    card = card
                }
            end

            G.GAME.hands[picked_hand].level = G.GAME.hands[picked_hand].level - 1

            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Downgraded " .. picked_hand, colour = G.C.MULT, delay = 3})
            --card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgraded " .. context.scoring_name, colour = G.C.CHIPS, delay = 3})

            return {
                card = self,
                level_up = true,
                message = localize('k_level_up_ex')
            }


        end

	end
}
