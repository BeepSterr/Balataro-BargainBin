-- ASSETS
--Creates an atlas for cards to use
SMODS.Atlas {
	-- Key for code to find it with
	key = "Jokers",
	-- The name of the file, for the code to pull the atlas from
	path = "Jokers.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

-- RARITIES
assert(SMODS.load_file('Items/Rarities/Exotic.lua'))()

-- JOKERS
assert(SMODS.load_file('Items/Jokers/Overflow.lua'))()
assert(SMODS.load_file('Items/Jokers/Vbucks.lua'))()
assert(SMODS.load_file('Items/Jokers/EggBasket.lua'))()
assert(SMODS.load_file('Items/Jokers/CollegeFund.lua'))()
assert(SMODS.load_file('Items/Jokers/GuestPass.lua'))()
assert(SMODS.load_file('Items/Jokers/Timeout.lua'))()
assert(SMODS.load_file('Items/Jokers/Izanagis.lua'))()
assert(SMODS.load_file('Items/Jokers/Slotmachine.lua'))()

-- CONSUMABLES
assert(SMODS.load_file('Items/Consumables/ExoticEngram.lua'))()

-- CHALLENGES
assert(SMODS.load_file('Items/Challenges/Timeout.lua'))()
assert(SMODS.load_file('Items/Challenges/Ascendant.lua'))()
assert(SMODS.load_file('Items/Challenges/PureChance.lua'))()
