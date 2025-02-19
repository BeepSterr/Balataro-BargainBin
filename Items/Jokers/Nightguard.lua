if beepsterr.bargainbin.debug then

local nightguard = {}

nightguard.phase = {
    WAITING_TO_START = 0,
    PLAYING = 1,
    NIGHT_LOST = 2,
    NIGHT_WON = 3,
}

nightguard.rewards = {
    {
        chips = 0,
        x_chips = 0,
        mult = 0,
        x_mult = 0,
        dollars = 0,
    }
}

SMODS.Atlas {
	key = "Nightguard",
	path = "Nightguard.png",
	px = 142,
	py = 95
}

SMODS.Joker {
	key = 'nightguard',
	loc_txt = {
		name = 'The Security Gig',
		text = {
			"{C:attention}-#1#{} and {C:chips}+#2#{} Chips",
		}
	},
	rarity = 3,
	blueprint_compat = false,
	atlas = 'Nightguard',
	pos = { x = 0, y = 0 },
	cost = 0,
    display_size = { x = 142, y = 95 },
    pixel_size = { x = 142, y = 95 },
    config = {
        layers = {
            eyes_left = {
                atlas = {
                    key = "beepsterr_bargainbin_Nightguard",
                    x = 0,
                    y = 1
                },
                extra = {
                    attached = false,
                },
            },
        },
        extra = {
            night = 1,
            update = 60,
            phase = nightguard.phase.WAITING_TO_START,
            cost = 8.99,
            chips = 1000
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.update,
                card.ability.extra.cost,
                card.ability.extra.chips
            }
        }
    end,
    update = function(self, card)

        if card.ability.extra.update > 0 then
            card.ability.extra.update = card.ability.extra.update - 1
            return
        end

        card.ability.extra.update = 60

        card.ability.layers.eyes_left.atlas.x = card.ability.layers.eyes_left.atlas.x + 1
        if card.ability.layers.eyes_left.atlas.x > 3 then
            card.ability.layers.eyes_left.atlas.x = 0
        end
    end,
	calculate = function(self, card, context)

	end
}

end