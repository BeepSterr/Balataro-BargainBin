return {
    misc={
        challenge_names = {
            overflow_challenge = "Desynced",
            timer_challenge = "Speedrun",
            pure_chance = "Pure Chance"
        },
        labels = {
            k_exotic = "Exotic",
        },
        labels = {
             k_exotic = "Exotic",
         }
    },
    descriptions = {
        Back={},
        Blind={},
        Edition={},
        Enhanced={},
        Planet={},
        Spectral={
            c_beepsterr_bargainbin_exotic_engam = {
                name = 'Exotic Engram',
                text = {
                    'When {C:attention}Blind{} is selected',
                    'gain {C:attention}1{} random {C:planet}Symbol{}',
                    'and {C:attention}1{} random {C:mult}Mult{}',
                },
            },
        },
        Stake={},
        Tag={},
        Tarot={},
        Voucher={},
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
        Joker = {
            j_beepsterr_bargainbin_slotmachine = {
                name = 'Slot Machine',
                text = {
                    'When {C:attention}Blind{} is selected',
                    'roll the slot machine.',
                    'If any {C:planet}Symbols{} match scored cards',
                    'win {E:1,C:attention,s:1.5}Prizes!{}',
                },
            },
            j_beepsterr_bargainbin_college_fund = {
                name = 'College Funds',
                text = {
                    "When blind is selected {C:attention}-$#1#{}",
                    "and add {C:attention}$#2#{} to sell value",
                },
            },
            j_beepsterr_bargainbin_egg_basket = {
                name = 'Egg Basket',
                text = {
                    "Upgrade level of played poker hand",
                    "Downgrade level of random poker hand",
                },
            },
            j_beepsterr_bargainbin_guest_pass = {
                name = 'Guest Pass',
                text = {
                    "{C:mult}+#1#{} Mult for each scored {C:attention}face card{}",
                    "{C:mult}-#1#{} Mult for each scored {C:attention}numbered card{}",
                    "{C:inactive}(Currently {}{C:mult}+#2#{}{C:inactive}){}"
                }
            },
            j_beepsterr_bargainbin_izanagis = {
                name = "Izanagi's Burden",
                text = {
                    "After {C:attention}Blind{} is selected",
                    "Lose all {C:mult}Discards{} and all but 1 {C:chips}Hand{}",
                    "{X:mult,C:white} X1 {} per consumed hand and discard this blind",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {}{C:inactive}){}",
                }
            },
            j_beepsterr_bargainbin_overflow = {
                name = 'Overflow',
                text = {
                    "Increase {C:attention}rank{} of",
                    "all scored cards"
                }
            },
            j_beepsterr_bargainbin_timeout = {
                name = 'Double Time',
                text = {
                    "{C:chips}+#1#{} chips, reduced by {C:chips}#2#{} chips each second",
                    "gains {C:chips}+#3#{} chips when {C:attention}blind is selected{}",
                    "{S:1.1,C:red,E:2}self destructs when chips reach 0{}"
                }
            },
            j_beepsterr_bargainbin_vbucks = {
                name = 'V-Buck Card',
                text = {
                    "{C:attention}-#1#{} and {C:chips}+#2#{} Chips",
                }
            },
        },
    },
}