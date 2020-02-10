require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/path_light.zip"),
}

local function onhammered(inst, worker)
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst:Remove()
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_pot")
end

local function fuelupdate(inst)
	inst.components.fueled:GetPercent()
end

local function turnon(inst)
	if not inst.components.fueled:IsEmpty() then
		inst.components.fueled:StartConsuming()
		inst.Light:Enable(true)
		inst.Light:SetRadius(TUNING.PATHLIGHTS_RADIUS)
		inst.Light:SetFalloff(.5)
--		inst.Light:SetIntensity(TUNING.PATHLIGHTS_INTENSITY * 0.85 / 255)
		inst.Light:SetIntensity(0.7)
		inst.Light:SetColour((TUNING.PATHLIGHTS_R / 255) or 0, (TUNING.PATHLIGHTS_G / 255)  or 0, (TUNING.PATHLIGHTS_B / 255) or 0)
		inst.AnimState:PlayAnimation("idle_on")
		fuelupdate(inst)
	end
end

local function turnoff(inst)
	inst.Light:Enable(false)
	inst.AnimState:PlayAnimation("idle_off")
	inst.components.fueled:StopConsuming()
end

local function fuelit_update(inst)
	if inst.status == 0 then
		turnoff(inst)
	elseif inst.status == 1 then
		if TheWorld.state.isday then 
			turnoff(inst)
		else
			turnon(inst)
		end
	elseif inst.status == 2 then
		turnon(inst)
	else
		if TheWorld.state.isday then 
			turnoff(inst)
		else
			turnon(inst)
		end
	end
end

local function takefuel(inst)
	fuelit_update(inst)
end

local function nofuel(inst)
	if inst.components.fueled:IsEmpty() then
	inst.Light:Enable(false)
	inst.AnimState:PlayAnimation("idle_off")
	end
end

local function onbuilt(inst)
	inst.components.fueled:InitializeFuelLevel(TUNING.LARGE_FUEL)
end

local function onsave(inst, data)
	data.status = inst.status
	return data
end

local function onload(inst, data)
	if data.status then
		inst.status = data.status
	end
end

local function keeptargetfn()
	return false
end

local function fn()
	local inst = CreateEntity()
	
	local fragile = TUNING.PATHLIGHTS_FRAGILE

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()		
	inst.entity:AddNetwork()
	inst.entity:AddLight()

	MakeObstaclePhysics(inst, .5)

	inst.AnimState:SetBank("path_light")
	inst.AnimState:SetBuild("path_light")
	inst.AnimState:PlayAnimation("idle_off")
	
	if fragile then
		inst:AddTag("wall")
		inst:AddTag("noauradamage")
		inst:AddTag("nointerpolate")
	end
	inst:AddTag("path_light")

	if not TheWorld.ismastersim then
		return inst
	end

	inst.entity:SetPristine()

	if inst.status == nil then
		inst.status = 1
	end

	inst:AddComponent("fueled")
	inst.components.fueled:SetSections(4)
	inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
	inst.components.fueled.fueltype = FUELTYPE.BURNABLE
	inst.components.fueled:SetDepletedFn(nofuel)
	inst.components.fueled:SetUpdateFn(fuelit_update)
	inst.components.fueled.ontakefuelfn = takefuel
	inst.components.fueled.accepting = true

	if FueledtLight then
		inst.components.fueled.rate = .5
	else
		inst.components.fueled.rate = 0
	end

	
	inst:DoPeriodicTask(2, function()
		fuelit_update(inst)
	end)

	fuelit_update(inst)

	if fragile then
		inst:AddComponent("combat")
		inst.components.combat:SetKeepTargetFunction(keeptargetfn)

		inst:AddComponent("health")
		inst.components.health:SetMaxHealth(1)
		inst.components.health:SetCurrentHealth(1)
		inst.components.health.nofadeout = true
		inst.components.health.canheal = false
		inst.components.health.fire_damage_scale = 0
		inst:ListenForEvent("death", onhammered)
	end
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(onhammered)

	inst:AddComponent("inspectable")

	inst:ListenForEvent("onbuilt", onbuilt)
	
	inst:ListenForEvent("switchmode", function(inst)
		if inst.status >= 2 then
			inst.status = 0
			inst.SoundEmitter:PlaySound("dontstarve/pig/pighut_lightoff")
		else
			inst.status = inst.status + 1
			inst.SoundEmitter:PlaySound("dontstarve/pig/pighut_lighton")
		end
	end)
	
	inst.OnSave = onsave
	inst.OnLoad = onload

	return inst
end

return Prefab("common/objects/path_light", fn, assets),
	MakePlacer( "common/path_light_placer", "path_light", "path_light", "idle_off" )