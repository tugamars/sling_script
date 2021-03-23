-- Based off Scully's Sling Script // Made by: Tugamars#2064

local Sling = {
	
}

Sling[1]={
		WeaponIsSlinged = false,
		WeaponObject = nil,
		Weapon = nil,
		Ammo = nil,
		Attachements={}
	}

Sling[2]={
		WeaponIsSlinged = false,
		WeaponObject = nil,
		Weapon = nil,
		Ammo = nil,
		Attachements={}
	}

RegisterCommand(Config.Command, function(source, args, raw)
	
	local pl = GetPlayerPed(-1)
	
	if args[1] == "1" then
		print("Slinging weapon 1")
		SlingWeapon(1,pl)
	elseif args[1] == "2" then
		print("Slinging weapon 2")
		SlingWeapon(2,pl)	
	end
	
end)

function SlingWeapon(weapon,player)
	if (weapon ~= 1 and weapon ~= 2) then return false end
	
	local pedWeapon=GetSelectedPedWeapon(player)
	
	if Config.Weapons[""..pedWeapon] ~= nil and weapon==1 and Config.Weapons[""..pedWeapon]["allowone"] == false then return false end
	
	if Config.Weapons[""..pedWeapon] ~= nil and Sling[weapon].WeaponIsSlinged ~= true then
		
		
		
		Sling[weapon].Weapon = pedWeapon
		Sling[weapon].Ammo = GetAmmoInPedWeapon(player, pedWeapon)
		Wait(100)
		
		local objectName=GetHashKey(Config.Weapons[""..pedWeapon].objectName)
		RequestModel(objectName)
		while not HasModelLoaded(objectName) do
			Wait(100)
		end
		
		Sling[weapon].Attachements={}
		
		print("Weapon comp")
		for k,v in pairs(Config.Weapons[""..pedWeapon]["attachaments"]) do
			if(HasPedGotWeaponComponent(player,pedWeapon,v) == 1) then 
				table.insert(Sling[weapon].Attachements, v)
			end
		end
	
		
		Sling[weapon].WeaponObject = CreateObject(objectName, 1.0, 1.0, 1.0, true, true, false)
		
		AttachEntityToEntity(Sling[weapon].WeaponObject, player, GetPedBoneIndex(player, 18905), 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 1, 1, 0, 1, 1, 0)
		
		RemoveWeaponFromPed(player, Sling[weapon].Weapon)
		Sling[weapon].WeaponIsSlinged=true
		SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
		RequestAnimDict("mp_player_intdrink")
		while not HasAnimDictLoaded("mp_player_intdrink") do 
		    Wait(0) 
		end
		
		if weapon == 1 then 
			TaskPlayAnim(player, 'mp_player_intdrink', 'loop_bottle', 8.0, -8.0, 200, 49, 0, 0, 0, 0)
			Wait(100)
			ClearPedTasks(player)
			RemoveAnimDict("mp_player_intdrink")
			AttachEntityToEntity(Sling[weapon].WeaponObject, player, GetPedBoneIndex(player, 24816), 0.0, 0.27, -0.02, 0.0, 320.0, 175.0, 1, 1, 0, 0, 2, 1)
		else
			TaskPlayAnim(player, 'mp_player_intdrink', 'loop_bottle', 8.0, -8.0, 400, 49, 0, 0, 0, 0)
			Wait(400)
			ClearPedTasks(player)
			RemoveAnimDict("mp_player_intdrink")
			AttachEntityToEntity(Sling[weapon].WeaponObject, player, GetPedBoneIndex(player, 24816), 0.05, -0.18, -0.02, 0.0, 165.0, 0.0, 1, 1, 0, 0, 2, 1)
		end
		
	elseif Sling[weapon].WeaponIsSlinged then 
		
		RequestAnimDict("mp_player_intdrink")
		while not HasAnimDictLoaded("mp_player_intdrink") do 
			Wait(0) 
		end
		
		if weapon==1 then 
			TaskPlayAnim(player, 'mp_player_intdrink', 'loop_bottle', 8.0, -8.0, 200, 49, 0, 0, 0, 0)
			Wait(50)
			AttachEntityToEntity(Sling[weapon].WeaponObject, player, GetPedBoneIndex(player, 18905), 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 1, 1, 0, 1, 1, 0)
			Wait(50)
		else
			TaskPlayAnim(player, 'mp_player_intdrink', 'loop_bottle', 8.0, -8.0, 400, 49, 0, 0, 0, 0)
			Wait(300)
			AttachEntityToEntity(Sling[weapon].WeaponObject, player, GetPedBoneIndex(player, 18905), 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 1, 1, 0, 1, 1, 0)
			Wait(100)
		end
		
		ClearPedTasks(player)
		RemoveAnimDict("mp_player_intdrink")
		if DoesEntityExist(Sling[weapon].WeaponObject) then
			DeleteObject(Sling[weapon].WeaponObject)
			SetModelAsNoLongerNeeded(Sling[weapon].WeaponObject)
		end
		
		GiveWeaponToPed(player, Sling[weapon].Weapon, Sling[weapon].Ammo, false)
		
		for k,v in pairs(Sling[weapon].Attachements) do 
			GiveWeaponComponentToPed(player, Sling[weapon].Weapon,v )
		end
		
		SetCurrentPedWeapon(player, Sling[weapon].Weapon, true)
		SetPedAmmo(player, Sling[weapon].Weapon, Sling[weapon].Ammo)
		
		Sling[weapon].WeaponIsSlinged=false
	end
	
end