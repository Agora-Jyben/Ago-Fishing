PecheConfig = {}

PecheConfig.jeveuxmarker = true --- true = Oui | false = Non (afficher les markers)
PecheConfig.jeveuxblips = true --- true = Oui | false = Non (afficher les blips)
PecheConfig.markerDebug = false --- true = Oui | false = Non (afficher les merkerSize)

PecheConfig.info = {
    logoPrice = "€",
    Blips = {
        pos = {
            {x = 2199.136, y = 3946.759, z = 30.886, interaction = "~w~[~b~E~w~] ~b~pour ~g~Sortir~w~/~r~Rentrer~b~ la canne a pêche !"},
            {x = 1325.492, y = 4198.220, z = 33.908, interaction = "~w~[~b~E~w~] ~b~pour ~g~Sortir~w~/~r~Rentrer~b~ la canne a pêche !"},
            {x = -1623.55, y = 5288.961, z = 5.1290, interaction = "~w~[~b~E~w~] ~b~pour ~g~Sortir~w~/~r~Rentrer~b~ la canne a pêche !"},
            {x = 4022.249, y = 4570.946, z = 2.4490, interaction = "~w~[~b~E~w~] ~b~pour ~g~Sortir~w~/~r~Rentrer~b~ la canne a pêche !"},
            {x = 5319.491, y = -4743.33, z = 2.4066, interaction = "~w~[~b~E~w~] ~b~pour ~g~Sortir~w~/~r~Rentrer~b~ la canne a pêche !"}
        },
        sizeAction = 45,
        blipID = 68,
        SizeBlip = 0.9,
        ColorBlip = 38,
        name = "Zone Pêche",
        nameRevente = "Revendeur Poisson",
    },

    NameUseItem = "cannepeche",
    NameAppatItem = "appatpoisson",
    itemMax = 2,

    Items = {
        [1] = {name = "fishcat", label = "Poisson Chat", price = math.random(1,3)},
        [2] = {name = "fishcarp", label = "Carpe", price = math.random(1,5)},
    },

    Revente = {
        pedhash = "s_m_m_linecook",
        posPed = {x = 139.6694, y = -3098.28, z = 5.8963},
        anglePed = 357.43,
        Interaction = "~w~[~b~E~w~]~b~ Pour interagir avec le revendeur",

    }

}
