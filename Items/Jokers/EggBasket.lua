SMODS.Joker {
	key = 'egg_basket',
	loc_txt = {
		name = 'Egg Basket',
		text = {
			"Upgrade level of played poker hand",
			"Downgrade level of random poker hand",
		}
	},
	rarity = 2,
	atlas = 'Jokers',
	blueprint_compat = false,
	pos = { x = 2, y = 0 },
	cost = 6,
	calculate = function(self, card, context)

        if context.joker_main and not context.blueprint then

            print("Played hand", context.scoring_name, G.GAME.hands[context.scoring_name].level);
            local played_hand = G.GAME.hands[context.scoring_name];
            local available_hands = {}

            for hand_name ,hand in pairs(G.GAME.hands) do
                print("Checking", hand_name, hand.visible, hand.level, played_hand.level, context.scoring_name, context.scoring_name ~= played_hand.name)
                if hand.visible and hand.level > 1 and hand_name ~= context.scoring_name then
                    print("Hand", hand_name, "is available to level down")
                    table.insert(available_hands, hand_name)
                end
            end

            print("Now going to use random hand from ", available_hands)
            local picked_hand = pseudorandom_element(available_hands, pseudoseed('nihility'))
            if not picked_hand then
                print("No hands available to level down... :(")
                return {
                    message = "Nope!",
                    colour = G.C.JOKER_GREY,
                    card = card
                }
            end

            print("Hand", picked_hand, "is selected to level down")
            level_up_hand(card, context.scoring_name, 1);
            G.GAME.hands[picked_hand].level = G.GAME.hands[picked_hand].level - 1

            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Downgraded " .. picked_hand, colour = G.C.MULT, delay = 3})
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgraded " .. context.scoring_name, colour = G.C.CHIPS, delay = 3})

        end

	end
}
