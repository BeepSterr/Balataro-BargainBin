
-- global setup
beepsterr = beepsterr or {}
beepsterr.bargainbin = beepsterr.bargainbin or {}
beepsterr.bargainbin.prefix = "beepsterr_bargainbin"
beepsterr.bargainbin.config = SMODS.current_mod.config
beepsterr.bargainbin.util = beepsterr.bargainbin.util or {}

-- release flags
beepsterr.bargainbin.debug = true

-- Start loading mod content
assert(SMODS.load_file('Items/Loader.lua'))()


beepsterr.rendering = {}

beepsterr.rendering.sprite_cleanup_queue = {}
beepsterr.rendering.get_layer_key = function(layers)

    local key = "layers_"
    for k, v in pairs(layers) do
        key = key .. "|" .. k .. ":" .. v.atlas.key .. ":" .. v.atlas.x .. ":" .. v.atlas.y
    end

    return key

end

beepsterr.rendering.layer_cleanup = function()

    for k, v in pairs(beepsterr.rendering.sprite_cleanup_queue) do
        v:remove()
    end

    beepsterr.rendering.sprite_cleanup_queue = {}

end

-- LOVELY patched to run inside card:draw()
beepsterr.bargainbin.util.setup_card_layers = function(self)

    beepsterr.rendering.layer_cleanup()

    -- self.ability.layers
    if self.ability.layers and (self.config.center.discovered or self.bypass_discovery_center) then


        for k, v in pairs(self.ability.layers) do

            if v.atlas and v.atlas.key and G.ASSET_ATLAS[v.atlas.key] then

                self.children['layer_' .. k] = Sprite(
                    --[[ X     ]] self.T.x,
                    --[[ Y     ]] self.T.y,
                    --[[ W     ]] G.ASSET_ATLAS[v.atlas.key].px,
                    --[[ H     ]] G.ASSET_ATLAS[v.atlas.key].py,
                    --[[ ATLAS ]] G.ASSET_ATLAS[v.atlas.key],
                    --[[ S_POS ]] { x = v.atlas.x, y = v.atlas.y }
                )

                self.children['layer_' .. k].states.hover.can = false
                self.children['layer_' .. k].states.click.can = false
                self.children['layer_' .. k].no_draw = true
                self.children['layer_' .. k].role.draw_major = self
                self.children['layer_' .. k]:draw_shader('dissolve',0, nil, nil, self.children.center,0, 0,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
                self.children['layer_' .. k]:draw_shader('dissolve', nil, nil, nil, self.children.center, 0, 0)

                -- insert for cleanup next frame
                table.insert(beepsterr.rendering.sprite_cleanup_queue, self.children['layer_' .. k])

            else
                print('atlas not found for layer "' .. k)
            end

            self.layer_key = beepsterr.rendering.get_layer_key(self.ability.layers)

        end

    end

end