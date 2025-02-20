[manifest]
version = "1.0.0"
dump_lua = true
priority = -1

[[patches]]
[patches.pattern]
target = "functions/UI_definitions.lua"
pattern = '''if (card.area == G.jokers and G.jokers or card.area == G.consumeables and G.consumeables) and G.STATE ~= G.STATES.TUTORIAL then --Add a sell button'''
position = "after"
payload = '''
if (card.area == G.jokers and G.jokers) and G.STATE ~= G.STATES.TUTORIA and card.ability.re_rollable then --Add a sell button
    base_attach.children.roll = G.UIDEF.card_focus_button{
      card = card, parent = base_attach, type = 'reroll',
      func = 'can_sell_card', button = 'sell_card', card_width = card_width
    }
end
'''
match_indent = true

[[patches]]
[patches.pattern]
target = "functions/UI_definitions.lua"
pattern = '''elseif args.type == 'buy' then'''
position = "before"
payload = '''
  elseif args.type == 'reroll' then
    button_contents = {n=G.UIT.T, config={text = localize('b_reroll'),colour = G.C.WHITE, scale = 0.5}}
'''
match_indent = true