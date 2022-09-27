ESX = nil 
local isOpened = false
local notfreezee = true
Keys = { 
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
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Citizen.Wait(1) 
	end 
		PlayerData = ESX.GetPlayerData() 
end) 
 
RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	PlayerData = xPlayer 
end) 
 
RegisterNetEvent('esx:setJob') 
AddEventHandler('esx:setJob', function(job) 
	PlayerData.job = job 
end) 

Ce = {
    [1] = 'Menu'
}

Citizen.CreateThread(function()   ---- สร้าง Maker เด้งๆ  และจุด X Y Z ของ Event
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
        test = true
        for key, data in pairs(Config) do

            
            

            if GetDistanceBetweenCoords(coords, data.warpMainPosition, true) < 10  then
                test = false
                DrawMarker(1, data.warpMainPosition, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 0.5, 255 ,20 ,147, 255, false, false, 2, false, false, false, false)
            end

            if GetDistanceBetweenCoords(coords, data.backWarpPosition, true) < 10  then
                test = false
                DrawMarker(1, data.backWarpPosition, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 0.5, 255 ,20 ,147, 255, false, false, 2, false, false, false, false)
            end

            if GetDistanceBetweenCoords(coords, data.warpMainPosition, true) < 2  then
                ESX.ShowHelpNotification('Press ~r~[E] ~g~to Teleport ')
                if IsControlJustReleased(0, Keys['E']) then
                    TriggerServerEvent('awaken_Teleport:Checkitem', data.key, data.requiredItem)
                end
            end

            if GetDistanceBetweenCoords(coords, data.backWarpPosition, true) < 2 then 
                ESX.ShowHelpNotification('Press ~r~[E] ~g~to Teleport ')
                if IsControlJustReleased(0, Keys['E']) then
                    Wait(1000)
                    SendNUIMessage({
                        display = true
                    })
                    SetEntityCoords(playerPed, data.warpMainPosition)
                    FreezeEntityPosition(PlayerPedId(), true)
                    notfreezee = true
                    Citizen.Wait(5000)
                    SendNUIMessage({
                        display = false
                    })
                    Citizen.CreateThread(function()
                        while true do
                            Citizen.Wait(0)
                            if notfreezee then
                                DrawTxt(0.930, 0.700, 1.0,1.0,0.55,"~r~กด ~w~[G] ~r~เพื่อเดิน", 255,255,255,255)
                                if IsControlJustReleased(0, Keys["G"]) then
                                    FreezeEntityPosition(PlayerPedId(), false)	
                                    notfreezee = false
                                end
                            end
                        end
                    end)
                end	
            end

        end
        if test then
            Wait(500)
        end
	end	
end)

RegisterNetEvent('awaken:menu')           -------- ส่วนของเมนู
AddEventHandler('awaken:menu', function(name, value, backWarpPosition,cost)
local ped = PlayerPedId()
ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true

    table.insert(elements, {
        label = name,
        value =  value,
        coords = backWarpPosition,
        cost = cost
    })

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'TeleportMenu', {
		title    = 'Teleport Menu',
		align    = 'right',
		elements = elements
	}, function(data,menu)
        Close()	
        Citizen.Wait(1000)
        if value == 'war_zone' then
            ESX.TriggerServerCallback('awaken:checkMoney',function(cost)
                if cost then
                    SendNUIMessage({
                        display = true
                    })
                    SetEntityCoords(ped, backWarpPosition)	
                    FreezeEntityPosition(PlayerPedId(), true)
                    notfreezee = true
                    Citizen.Wait(5000)
                    SendNUIMessage({
                        display = false
                    })
                    Citizen.CreateThread(function()
                        while true do
                            Citizen.Wait(0)
                            if notfreezee then
                                DrawTxt(0.930, 0.700, 1.0,1.0,0.55,"~r~กด ~w~[G] ~r~เพื่อเดิน", 255,255,255,255)
                                if IsControlJustReleased(0, Keys["G"]) then
                                    FreezeEntityPosition(PlayerPedId(), false)	
                                    notfreezee = false
                                end
                            end
                        end
                    end)
                end
            end)
        else
            SendNUIMessage({
                display = true
            })
            SetEntityCoords(ped, backWarpPosition)	
            FreezeEntityPosition(PlayerPedId(), true)
            notfreezee = true
            Citizen.Wait(5000)
            SendNUIMessage({
                display = false
            })
            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(0)
                    if notfreezee then
                        DrawTxt(0.930, 0.700, 1.0,1.0,0.55,"~r~กด ~w~[G] ~r~เพื่อเดิน", 255,255,255,255)
                        if IsControlJustReleased(0, Keys["G"]) then
                            FreezeEntityPosition(PlayerPedId(), false)	
                            notfreezee = false
                        end
                    end
                end
            end)
        end	
	end, function(data,menu)
		menu.close()
		menuOpen = false
	end)
end)

Citizen.CreateThread(function()
    for key, data in pairs(Config) do
        RegisterNetEvent('awakenTeleport:checkend_'..data.key)
        AddEventHandler('awakenTeleport:checkend_'..data.key, function()
            TriggerEvent('awaken:menu', data.name, data.key, data.backWarpPosition)	
        end)
    end
end)

function Close()
	ESX.UI.Menu.CloseAll()
end

-- function Fadein ()
-- 	Citizen.CreateThread(function()
-- 		while true do
-- 				DoScreenFadeOut(3000)
-- 				Wait(3000)
-- 				DoScreenFadeIn(300)			
-- 				Wait(800)	
-- 			break
-- 			end
-- 	end)
-- end

RegisterFontFile('font4thai')
fontId = RegisterFontId('font4thai')

function DrawTxt(x,y ,width,height,scale, text, r,g,b,a)
	SetTextFont(fontId)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end