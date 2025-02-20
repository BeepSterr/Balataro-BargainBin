SMODS.Atlas {
    key = "Consumables",
    path = "consumables.png",
    px = 65,
    py = 65
}

SMODS.ConsumableType {
    key = "beepsterr_Engram",
    collection_rows = { 1, 1 },
    primary_colour = HEX("cdad36"),
    secondary_colour = HEX("cdad36"),
    loc_txt = {
        name = "Engrams",
        collection = "Engrams",
        undiscovered = {
            name = "Engram",
            desc = "A mysterious engram. What could be inside?"
        }
    }
}

SMODS.Consumable {

    key = "exotic_engram",
    set = "beepsterr_Engram",
    atlas = "Consumables",
    pos = { x = 0, y = 0 },

    in_pool = function(self,args)
        print(args)
        return true
    end

}