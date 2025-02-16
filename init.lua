
-- global setup
beepsterr = beepsterr or {}
beepsterr.bargainbin = beepsterr.bargainbin or {}
beepsterr.bargainbin.prefix = "beepsterr_bargainbin"
beepsterr.bargainbin.config = SMODS.current_mod.config

-- release flags
beepsterr.bargainbin.debug = true

-- Start loading mod content
assert(SMODS.load_file('Items/Loader.lua'))()