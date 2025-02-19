[manifest]
version = "1.0.0"
dump_lua = true
priority = -1

[[patches]]
[patches.pattern]
target = "card.lua"
pattern = 'if center.name == "Wee Joker" and (center.discovered or self.bypass_discovery_center) then'
match_indent = true
position = "before"
payload = '''
    if center.name == "j_beepsterr_bargainbin_nightguard" and (center.discovered or self.bypass_discovery_center) then
        print(center.layers)
        W = W*2
        self.T.w = W
    end
'''