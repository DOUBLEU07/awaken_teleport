ESX = nil 
 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

ESX.RegisterServerCallback('awaken:CheckitemOut', function(source, cb, checkitem)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(Config.ItemnameIce)

	if item.count >= 1  then   
        xPlayer.removeInventoryItem(Config.ItemnameIce,1)
        cb(true)
    else
        cb(false)
    end
end)


RegisterServerEvent('awaken_Teleport:Checkitem')
AddEventHandler('awaken_Teleport:Checkitem', function(value, requiredItem)
    local value = value
    local Itemname = requiredItem
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(Itemname)
	if item.count >= 1  then   
        TriggerClientEvent('awakenTeleport:checkend_'..value, source)
    else
        TriggerClientEvent("pNotify:SendNotification",source,
		{text = " <center><b style ='color:yellow'>คุณไม่่มีไอทม "..ESX.GetItemLabel(Itemname).."",
		type = "alert", timeout = 5000, 
		layout = "bottomCenter"})	
    end
end)


ESX.RegisterServerCallback('awaken:checkMoney', function(source, cb, cost)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 0 then
		xPlayer.removeMoney(0)
		cb(true)
	else
        TriggerClientEvent('esx:showNotification', source, ("Not enough Money"))
		cb(false)
	end
end)


RegisterServerEvent('awaken:cost')
AddEventHandler('awaken:cost', function(cost)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.getMoney() >= cost then		
		xPlayer.removeMoney(cost)
	else
		TriggerClientEvent('esx:showNotification', source, ("Not enough Money"))
	end
end)

RegisterServerEvent('Removeitem')
AddEventHandler('Removeitem', function(item)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    

    xPlayer.removeInventoryItem(item,1)


end)


RegisterServerEvent('awaken_Teleport:additem')
AddEventHandler('awaken_Teleport:additem', function(item)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    

    xPlayer.addInventoryItem("painkillerwarzone",1)
    xPlayer.addInventoryItem("aed",1)


end)

RegisterServerEvent('awaken_Teleport:removeitem')
AddEventHandler('awaken_Teleport:removeitem', function(item)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(Config.ItemnameIce,1)
end)