ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem(PecheConfig.info.NameUseItem, function(source)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local actpech = true
	TriggerClientEvent('AgoPeche:activity', _source, actpech)
end)

RegisterNetEvent('Peche:recolte')
AddEventHandler('Peche:recolte', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemSelect = math.random(1, PecheConfig.info.itemMax)
    local itemName = PecheConfig.info.Items[itemSelect].name
    local nbitemdansinventaire = xPlayer.getInventoryItem(itemName).count
    local AppatPoisson = xPlayer.getInventoryItem(PecheConfig.info.NameAppatItem).count
    local CannePeche = xPlayer.getInventoryItem(PecheConfig.info.NameUseItem).count
   
    if AppatPoisson >= 1 then
        if CannePeche >= 1 then
            if nbitemdansinventaire <= 30 then
                xPlayer.addInventoryItem(itemName, 1)
                xPlayer.showNotification("Vous avez pêcher x1 ~b~"..PecheConfig.info.Items[itemSelect].label)
                xPlayer.removeInventoryItem(PecheConfig.info.NameAppatItem, 1)
            else
                xPlayer.showNotification("Vous n'avez plus de place !")
            end
        else
            xPlayer.showNotification("Vous n'avez pas de Canne a pêche pour pêcher !")
        end
    else
        xPlayer.showNotification("Vous n'avez pas assez d'appât pour pêcher !")
    end
        
end)

RegisterNetEvent('Peche:RevendeurPrend')
AddEventHandler('Peche:RevendeurPrend', function(name, label, price, Nombre)
    local item = name
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    local PriceFinal = price*Nombre

    if nbitemdansinventaire >= Nombre then
        xPlayer.removeInventoryItem(item, Nombre)
        -- xPlayer.addMoney(PriceFinal)
        xPlayer.addMoney(PriceFinal)
        xPlayer.showNotification("Vous venez de vendre ~b~"..Nombre.." "..label.."\n~s~Gain pour vous ~g~".. PriceFinal .." "..PecheConfig.info.logoPrice)
    else
        xPlayer.showNotification("~r~Vous n'avez pas assez de ~b~"..label.." ~r~sur vous !")
    end
end)

RegisterNetEvent('Peche:RevendeurDonne')
AddEventHandler('Peche:RevendeurDonne', function(name, label, price, Nombre)
    local item = name
    local xPlayer = ESX.GetPlayerFromId(source)
    local MontantPlayer = xPlayer.getMoney()
    local PriceFinal = price*Nombre

    if MontantPlayer >= PriceFinal then
        xPlayer.addInventoryItem(item, Nombre)
        -- xPlayer.addMoney(PriceFinal)
        xPlayer.removeMoney(PriceFinal)
        xPlayer.showNotification("Vous venez d'acheter ~b~"..Nombre.." "..label.."\n~s~Total des dépenses : ~g~".. PriceFinal .." "..PecheConfig.info.logoPrice)
    else
        xPlayer.showNotification("~r~Vous n'avez pas assez d'argent sur vous !")
    end
end)