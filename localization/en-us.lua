return {
    descriptions = {

        Other={
            slotmachine_jackpot={
                name = 'Jackpot',
                text = {
                    'Earn {C:money,s:1.2}$100{}',
                    'if you roll {C:attention}3{} identical {C:planet}Symbols{}'
                },
            },
            slotmachine_rewards={
                name = 'Prize Table',
                text = {
                    '{s:1.1}1 {C:planet}Symbols{}',
                    '{C:money}$1{}, {C:chips}100{} Chips',
                    '',
                    '{s:1.1}2 {C:planet}Symbols{}',
                    '{C:money}$5{}, {C:mult}15{} Mult',
                    '',
                    '{s:1.1}3 {C:planet}Symbols{}',
                    '{C:money}$10{}, {X:chips,C:white}X2{} Chips, {X:mult,C:white}X2{} Mult',
                },
            }
        },

        -- this key should match the set ("object type") of your object,
        -- e.g. Voucher, Tarot, or the key of a modded consumable type
        Joker = {
            -- this should be the full key of your object, including any prefixes
            j_beepsterr_bargainbin_slotmachine = {
                name = 'Slot Machine',
                text = {
                    'When {C:attention}Blind{} is selected',
                    'roll the slot machine.',
                    'If any {C:planet}Symbols{} match scored cards',
                    'win {E:1,C:attention,s:1.5}Prizes!{}',
                },
            },
        },
    },
}