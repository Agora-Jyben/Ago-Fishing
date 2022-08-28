local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}



Citizen.CreateThread(function()
    while PecheConfig.markerDebug do
        local interval = 1000
        local pPed = PlayerPedId()
        local pCoords = GetEntityCoords(pPed, true)
        
        for k,v in pairs(PecheConfig.info.Blips.pos) do
            local distZPeche = #(pCoords-vector3(v.x, v.y, v.z))
            -- if distZPeche <= PecheConfig.info.Blips.sizeAction then
                interval = 5

                -- Debug Marker size
                local coord = vector3(v.x, v.y, v.z)
                local debug = PecheConfig.info.Blips.sizeAction+0.0
            
                DrawMarker(28,coord,0.0,0.0,0.0,0.0,0.0,0.0,debug,debug,debug,0,255,0,255,0,0,0,0,0,0,0)
                -- Fin Debug Marker size

                -- RageUI.Text({ message = "~w~Vous etes dans une zone de ~b~peche~w~ !", time_display = 1 })
                
            -- end
        end
        Citizen.Wait(interval)
    end
end)

Citizen.CreateThread(function()

    local ZonePecheBlip
    for k,v in pairs(PecheConfig.info.Blips.pos) do
        for i=1,k,1 do
            ZonePecheBlip = i
        end

        local AZonePeche = AddBlipForCoord(PecheConfig.info.Blips.pos[ZonePecheBlip].x, PecheConfig.info.Blips.pos[ZonePecheBlip].y, PecheConfig.info.Blips.pos[ZonePecheBlip].z)

        SetBlipSprite (AZonePeche, PecheConfig.info.Blips.blipID)
        SetBlipDisplay(AZonePeche, 4)
        SetBlipScale  (AZonePeche, PecheConfig.info.Blips.SizeBlip)
        SetBlipColour (AZonePeche, PecheConfig.info.Blips.ColorBlip)
        SetBlipAsShortRange(AZonePeche, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(PecheConfig.info.Blips.name)
        EndTextCommandSetBlipName(AZonePeche)
    end

    local RFishBlip = AddBlipForCoord(PecheConfig.info.Revente.posPed.x, PecheConfig.info.Revente.posPed.y, PecheConfig.info.Revente.posPed.z)
    SetBlipSprite (RFishBlip, PecheConfig.info.Blips.blipID)
    SetBlipDisplay(RFishBlip, 4)
    SetBlipScale  (RFishBlip, PecheConfig.info.Blips.SizeBlip)
    SetBlipColour (RFishBlip, PecheConfig.info.Blips.ColorBlip)
    SetBlipAsShortRange(RFishBlip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(PecheConfig.info.Blips.nameRevente)
    EndTextCommandSetBlipName(RFishBlip)

end)

local pecheActive = false
RegisterNetEvent("AgoPeche:activity")
AddEventHandler("AgoPeche:activity", function(actpech)
    Citizen.CreateThread(function()
        while actpech do
            
            local interval = 1000
            local pPed = PlayerPedId()
            local pCoords = GetEntityCoords(pPed, true)
            
            for k,v in pairs(PecheConfig.info.Blips.pos) do
                -- print(k, json.encode(v))
                local distZPeche = #(pCoords-vector3(PecheConfig.info.Blips.pos[k].x, PecheConfig.info.Blips.pos[k].y, PecheConfig.info.Blips.pos[k].z))
                if distZPeche <= PecheConfig.info.Blips.sizeAction then
                    interval = 5
                    RageUI.Text({ message = PecheConfig.info.Blips.pos[k].interaction, time_display = 1 })
                    if IsControlJustPressed(1,51) and pecheActive == false then
                        pecheActive = true
                        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true) 
                        RecoltePeche()
                    elseif IsControlJustPressed(1,51) and pecheActive == true then
                        pecheActive = false
                        actpech = false
                        ClearPedTasks(pPed)
                    elseif IsControlJustPressed(1,73) and pecheActive == true then
                        pecheActive = false
                        actpech = false
                        ClearPedTasks(pPed)
                    end
                end
            end
            Citizen.Wait(interval)
        end
    end)
end)

RecoltePeche = function()
    SetTimeout(10000, function()
        if pecheActive == true then 
            TriggerServerEvent("Peche:recolte")
            RecoltePeche()
        end
    end)
end

Citizen.CreateThread(function()
    local hash = GetHashKey(PecheConfig.info.Revente.pedhash)

    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
    end

    pedVenteFish = CreatePed("PED_TYPE_CIVFEMALE", PecheConfig.info.Revente.pedhash, PecheConfig.info.Revente.posPed.x, PecheConfig.info.Revente.posPed.y, PecheConfig.info.Revente.posPed.z-1, PecheConfig.info.Revente.anglePed, false, true)
    SetBlockingOfNonTemporaryEvents(pedVenteFish, true)
    FreezeEntityPosition(pedVenteFish, true)
    SetEntityInvincible(pedVenteFish, true)
    TaskStartScenarioInPlace(pedVenteFish, 'WORLD_HUMAN_CLIPBOARD', 0, false)
end)

Citizen.CreateThread(function()
	while true do
		local interval = 1000
		local pPed = PlayerPedId()
		local pCoords = GetEntityCoords(pPed, true)
			
        local RPeche =  #(pCoords-vector3(PecheConfig.info.Revente.posPed.x, PecheConfig.info.Revente.posPed.y, PecheConfig.info.Revente.posPed.z))
        if RPeche <= 4 then
            interval = 5
            -- DrawMarker(20, PecheConfig.info.Revente.posPed.x, PecheConfig.info.Revente.posPed.y, PecheConfig.info.Revente.posPed.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 197, 10, 10, 255, true, true, p19, true)
            if RPeche <= 1 then
                RageUI.Text({ message = PecheConfig.info.Revente.Interaction, time_display = 1 })
                if IsControlJustPressed(1,51) then
                    OpenReventeFish()
                end
            end
        end
		Citizen.Wait(interval)
	end
end)

OpenReventeFish = function()
    local MenuReventeFish = RageUI.CreateMenu("~b~Poissonier", "~y~Revendeur : ")
    MenuReventeFish:SetRectangleBanner(0, 0, 0)

    local PNJAchatFishMenu = RageUI.CreateSubMenu(MenuReventeFish, "~b~Revente", "~y~Vente Poissons : ")
    PNJAchatFishMenu:SetRectangleBanner(0, 0, 0) 

    local PlayerAchatFishMenu = RageUI.CreateSubMenu(MenuReventeFish, "~b~Achat", "~y~Achat poissons : ")
    PlayerAchatFishMenu:SetRectangleBanner(0, 0, 0) 
    
    RageUI.Visible(MenuReventeFish, not RageUI.Visible(MenuReventeFish))
    while MenuReventeFish do
        Citizen.Wait(0)
        RageUI.IsVisible(MenuReventeFish, true, false, true, function()
            --RageUI.Separator("")

            RageUI.ButtonWithStyle("Vente de poissons", nil, {RightLabel = " >>"}, true, function(Hovered,Active,Selected)
                if Selected then
                    
                end
            end,PNJAchatFishMenu)

            RageUI.ButtonWithStyle("Acheter de poissons", nil, {RightLabel = " >>"}, true, function(Hovered,Active,Selected)
                if Selected then
                    
                end
            end,PlayerAchatFishMenu)

        end, function() 
        end)

        RageUI.IsVisible(PNJAchatFishMenu, true, false, true, function()
            --Gain Joueur
            RageUI.Separator("~y~↓ ~b~Nos proposition ~y~↓")
            for k,v in pairs(PecheConfig.info.Items) do 
                RageUI.ButtonWithStyle("~y~[~r~"..k.."~y~] ~b~"..v.label, nil, {RightLabel = "~g~"..v.price.." "..PecheConfig.info.logoPrice}, true, function(Hovered,Active,Selected)
                    if Selected then
                        local name = v.name 
                        local label = v.label
                        local price = v.price 
                        local Nombre = FishReInput("Combien voulez-vous en vendre?", "", 3)
                        TriggerServerEvent("Peche:RevendeurPrend", name, label, price, tonumber(Nombre))
                    end
                end)
            end
        end, function() 
        end)

        RageUI.IsVisible(PlayerAchatFishMenu, true, false, true, function()
            --Perte Joueur
            RageUI.Separator("~y~↓ ~b~Nos produits ~y~↓")
            for k,v in pairs(PecheConfig.info.Items) do 
                RageUI.ButtonWithStyle("~y~[~r~"..k.."~y~]~b~ "..v.label, nil, {RightLabel = "~g~"..v.price.." "..PecheConfig.info.logoPrice}, true, function(Hovered,Active,Selected)
                    if Selected then
                        local name = v.name 
                        local label = v.label
                        local price = v.price 
                        local Nombre = FishReInput("Combien voulez-vous en prendre?", "", 3)
                        TriggerServerEvent("Peche:RevendeurDonne", name, label, price, tonumber(Nombre))
                    end
                end)
            end
        end, function() 
        end)

        if not RageUI.Visible(MenuReventeFish) and not RageUI.Visible(PNJAchatFishMenu) and not RageUI.Visible(PlayerAchatFishMenu) then 
            MenuReventeFish = RMenu:DeleteType("MenuReventeFish", true)
        end
    end
end

FishReInput = function(T, E, M)
	AddTextEntry('FMMC_KEY_TIP1_FISH', T .. '')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1_FISH", "", E, "", "", "", M)
	blockinput = true
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end
