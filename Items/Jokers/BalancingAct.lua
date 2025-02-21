
SMODS.Atlas {
	key = "BalancingActOverlay",
	path = "balancing_act_overlay.png",
	px = 71,
	py = 95
}

SMODS.Joker {
	key = 'balancing_act',
	rarity = 2,
	--loc_txt = {
    --    name = "balancing_act",
    --    text = {
    --        '#1# (#2#) - #3#, #4#, #5#, #6#'
    --    }
    --},
	cost = 4,
	atlas = 'Jokers',
	blueprint_compat = false,
	pos = { x = 1, y = 1 },
    config = {
        update_delay = 0,
        layers = {
            overlay = { atlas = { key = "beepsterr_bargainbin_BalancingActOverlay", x = 0, y = 0, s = false }, },
        },
        extra = {
            xmult_base = 4,
            xmult_cached_value = 4,
            hearts_played = 0,
            diamonds_played = 0,
            clubs_played = 0,
            spades_played = 0,
           }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_base,
                card.ability.extra.xmult_cached_value,
                card.ability.extra.hearts_played,
                card.ability.extra.diamonds_played,
                card.ability.extra.clubs_played,
                card.ability.extra.spades_played,
            }
        }
    end,

    update = function(self, card)

        if not card.ability.layers then return end

        if card.ability.update_delay > 0 then
            card.ability.update_delay = card.ability.update_delay - 1
            return
        end

        card.ability.update_delay = 90
        if card.ability.layers.overlay.atlas.x == 0 then
            card.ability.layers.overlay.atlas.x = 1
        else
            card.ability.layers.overlay.atlas.x = 0
        end

        -- "Good" state
        card.ability.layers.overlay.atlas.y = 0

        -- "Questionable" state
        if card.ability.extra.xmult_cached_value <= 3 then
            card.ability.layers.overlay.atlas.y = 1
        end
        -- "Bad" state
        if card.ability.extra.xmult_cached_value <= 2 then
            card.ability.layers.overlay.atlas.y = 2
        end

        -- 1% chance joke sprite
        if math.random(1, 100) == 1 and card.ability.extra.xmult_cached_value > 2 then
            card.ability.layers.overlay.atlas.y = 3
            card.ability.layers.overlay.atlas.x = 0
        end

    end,

    calculate = function(self, card, context)

        -- No Blueprint!
        if context.blueprint then return end

        -- Store cards
        if context.joker_main then

            card.ability.extra.current_cards = {}
            for i = 1, #context.scoring_hand do

                local other_card = context.scoring_hand[i]

                if other_card:is_suit("Hearts") then
                    card.ability.extra.hearts_played = card.ability.extra.hearts_played + 1
                end
                if other_card:is_suit("Diamonds") then
                    card.ability.extra.diamonds_played = card.ability.extra.diamonds_played + 1
                end
                if other_card:is_suit("Clubs") then
                    card.ability.extra.clubs_played = card.ability.extra.clubs_played + 1
                end
                if other_card:is_suit("Spades") then
                    card.ability.extra.spades_played = card.ability.extra.spades_played + 1
                end

            end

            -- get score difference
            local lowest_amount = math.min(card.ability.extra.hearts_played, card.ability.extra.diamonds_played, card.ability.extra.clubs_played, card.ability.extra.spades_played)
            local highest_amount = math.max(card.ability.extra.hearts_played, card.ability.extra.diamonds_played, card.ability.extra.clubs_played, card.ability.extra.spades_played)

            local x_mult = math.max(1, card.ability.extra.xmult_base - (highest_amount - lowest_amount) * 0.1)
            card.ability.extra.xmult_cached_value = x_mult

            return {
                x_mult = x_mult,
            }

        end

	end
}
