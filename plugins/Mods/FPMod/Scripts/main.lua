local LuaVR = require("LuaVR")
local runonce = false
local api = LuaVR.api;
local uobjects = LuaVR.types.FUObjectArray.get()

UEVR_UObjectHook.activate()

local params = LuaVR.params
local callbacks = params.sdk.callbacks

CurWeap = "None"
ActiveWeap = "Not Selected"
Interacting = false
InteractOnce = false
InIntroCut = false
IntroCutOnce = false
DeathHook = false
Ideath = false
LSEvents = false
EndStarted = false
LockActive = false
HEXActive = false
JustCentered = false
Playing = false
EndPCPlayed = false
Tutorial_Active = false
MGActive = false

Gunone = false
Dodid = false
Dodid2 = false
Dobody = false
Dobody2 = false
Doonce = false
Doonce2 = false
Doonce3 = false
Doonce4 = false
Doonce5 = false
Doonce6 = false
Pconce = false
local acut_not_hooked = true
local acuts_not_hooked = true
local sub_not_hooked = true
local md_not_hooked = true
local mgcut_not_hooked = true
local pc_not_hooked = true
local did_not_hooked = true
local grab_not_hooked = true
local endscene_not_hooked = true
local lock_not_hooked = true
local funcolar_not_hooked = true
local fountain_not_hooked = true
local hospital_not_hooked = true
local env_int_not_hooked = true



LuaVR.sdk.callbacks.on_pre_engine_tick(function(engine, delta)
Pawn = api:get_local_pawn(0)
--GetPawn = Pawn:get_full_name()


function CSShowBody()
    if Dobody == false then
        Dobody = true
        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(true)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
        if mesh:get_fname():to_string() == "CharacterMesh0" then
            if string.find(mesh:get_full_name(), "PersistentLevel.BP_Liev_") or string.find(mesh:get_full_name(), "PersistentLevel.BP_Samuel_") or string.find(mesh:get_full_name(), "PersistentLevel.BP_Raven_") then
                --print("found Character " .. mesh:get_full_name())
                Cmesh = mesh
                Cmesh:call("SetRenderInMainPass", true)
                Cmesh:call("SetVisibility", true)

                --break
            else
            
            end

            
        end
        end
    end
end

function CSHideBody()
    if Dobody2 == false then
        Dobody2 = true
        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(true)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
        if mesh:get_fname():to_string() == "CharacterMesh0" then
            if string.find(mesh:get_full_name(), "PersistentLevel.BP_Liev_") or string.find(mesh:get_full_name(), "PersistentLevel.BP_Samuel_") or string.find(mesh:get_full_name(), "PersistentLevel.BP_Raven_") then
                --print("CSHideBody " .. mesh:get_full_name())
                Cmesh = mesh
                Cmesh:call("SetRenderInMainPass", false)
                Cmesh:call("SetVisibility", false)

                --break
            else
            
            end

            
        end
        end
    end
end

function DeMP5()

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "MP510") and string.find(mesh:get_full_name(), "PersistentLevel") then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
				Fpmesh.RelativeRotation.Yaw = 0.0
                Fpmesh:call("SetRenderInMainPass", false)
				Fpmesh:call("SetVisibility", false)
				
                break
            end
        end

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.StaticMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_MP510_C") and mesh:get_fname():to_string() == "MagazineMesh" then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
                Fpmesh:call("SetRenderInMainPass", false)
				Fpmesh:call("SetVisibility", false)
				
                break
            end
        end

end

function CSMP5()
		local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SceneComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_MP510_C") and mesh:get_fname():to_string() == "DefaultSceneRoot" then
                CSEmesh = mesh
                --print(tostring(CSEmesh:get_full_name()))
				if string.find(Pawn:get_full_name(), "Harbor")
				then
					--print("CS MP5 Harbor")
					CSEmesh.RelativeRotation.Pitch = 0.0
					CSEmesh.RelativeRotation.Roll = 0.0
					CSEmesh.RelativeRotation.Yaw = 0.0
					CSEmesh.RelativeLocation.X = 0.0
					CSEmesh.RelativeLocation.Y = 0.0
					CSEmesh.RelativeLocation.Z = 0.0

				else
					--print("CS MP5")
					CSEmesh.RelativeRotation.Pitch = 0.0
					CSEmesh.RelativeRotation.Roll = 0.0
					CSEmesh.RelativeRotation.Yaw = 90.0
					CSEmesh.RelativeLocation.X = 0.0
					CSEmesh.RelativeLocation.Y = 0.0
					CSEmesh.RelativeLocation.Z = 0.0
				end
				
				
                break
            end
        end
end

function EMP5()

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "MP510") and string.find(mesh:get_full_name(), "PersistentLevel") then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
				if CutActive == true 
				then
					Fpmesh.RelativeRotation.Yaw = 0.0
				else	
					Fpmesh.RelativeRotation.Yaw = -90.0
				end
                Fpmesh:call("SetRenderInMainPass", true)
				Fpmesh:call("SetVisibility", true)
				
                --break
            end
        end

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.StaticMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_MP510_C") and mesh:get_fname():to_string() == "MagazineMesh" then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
                Fpmesh:call("SetRenderInMainPass", true)
				Fpmesh:call("SetVisibility", true)
				
                --break
            end
        end

end

function CSGlock()
		local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SceneComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Glock22_C") and mesh:get_fname():to_string() == "DefaultSceneRoot" then
                CSEmesh = mesh
				--print("CSGlock")
				CSEmesh.RelativeRotation.Pitch = 0.0
				CSEmesh.RelativeRotation.Roll = 0.0
				CSEmesh.RelativeRotation.Yaw = 90.0
                CSEmesh.RelativeLocation.X = 0.0
				CSEmesh.RelativeLocation.Y = 0.0
				CSEmesh.RelativeLocation.Z = 0.0
				
                break
            end
        end
end

function EGlock()

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Glock22_C") and string.find(mesh:get_full_name(), "PersistentLevel") then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
				if CutActive == true 
				then
					Fpmesh.RelativeRotation.Yaw = 0.0
				else	
					Fpmesh.RelativeRotation.Yaw = -90.0
				end
                Fpmesh:call("SetRenderInMainPass", true)
				Fpmesh:call("SetVisibility", true)
				
                --break
            end
        end

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.StaticMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Glock22_C") and mesh:get_fname():to_string() == "MagazineMesh" then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
                Fpmesh:call("SetRenderInMainPass", true)
				Fpmesh:call("SetVisibility", true)
				
                --break
            end
        end

end

function DeGlock()

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Glock22_C") and string.find(mesh:get_full_name(), "PersistentLevel") then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
				Fpmesh.RelativeRotation.Yaw = 0.0
                Fpmesh:call("SetRenderInMainPass", false)
				Fpmesh:call("SetVisibility", false)
				
                break
            end
        end

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.StaticMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Glock22_C") and mesh:get_fname():to_string() == "MagazineMesh" then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
                Fpmesh:call("SetRenderInMainPass", false)
				Fpmesh:call("SetVisibility", false)
				
                break
            end
        end

end

function CSDE()
		local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SceneComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_DesertEagle_C") and mesh:get_fname():to_string() == "DefaultSceneRoot" then
                CSEmesh = mesh
				--print("CSGlock")
				CSEmesh.RelativeRotation.Pitch = 0.0
				CSEmesh.RelativeRotation.Roll = 0.0
				CSEmesh.RelativeRotation.Yaw = 90.0
                CSEmesh.RelativeLocation.X = 0.0
				CSEmesh.RelativeLocation.Y = 0.0
				CSEmesh.RelativeLocation.Z = 0.0
				
                break
            end
        end
end

function EDEagle()

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_DesertEagle_C") and string.find(mesh:get_full_name(), "PersistentLevel") then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
				if CutActive == true 
				then
					Fpmesh.RelativeRotation.Yaw = 0.0
				else	
					Fpmesh.RelativeRotation.Yaw = -90.0
				end
                Fpmesh:call("SetRenderInMainPass", true)
				Fpmesh:call("SetVisibility", true)
				
                --break
            end
        end

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.StaticMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_DesertEagle_C") and mesh:get_fname():to_string() == "MagazineMesh" then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
                Fpmesh:call("SetRenderInMainPass", true)
				Fpmesh:call("SetVisibility", true)
				
                break
            end
        end

end

function DeDEagle()

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_DesertEagle_C") and string.find(mesh:get_full_name(), "PersistentLevel") then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
				Fpmesh.RelativeRotation.Yaw = -90.0
                Fpmesh:call("SetRenderInMainPass", false)
				Fpmesh:call("SetVisibility", false)
				
                --break
            end
        end

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.StaticMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_DesertEagle_C") and mesh:get_fname():to_string() == "MagazineMesh" then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
                Fpmesh:call("SetRenderInMainPass", false)
				Fpmesh:call("SetVisibility", false)
				
                break
            end
        end

end

function DeBur()

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Beretta_C") and string.find(mesh:get_full_name(), "PersistentLevel") then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
				Fpmesh.RelativeRotation.Yaw = 0.0
                Fpmesh:call("SetRenderInMainPass", false)
				Fpmesh:call("SetVisibility", false)
				
                --break
            end
        end

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.StaticMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Beretta_C") and mesh:get_fname():to_string() == "MagazineMesh" then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
                Fpmesh:call("SetRenderInMainPass", false)
				Fpmesh:call("SetVisibility", false)
				
                break
            end
        end

end

function EBur()

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Beretta_C") and string.find(mesh:get_full_name(), "PersistentLevel") then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
				Fpmesh.RelativeRotation.Yaw = 180.0
				Fpmesh.RelativeLocation.X = 5.0
				Fpmesh.RelativeLocation.Z = -3.0
                Fpmesh:call("SetRenderInMainPass", true)
				Fpmesh:call("SetVisibility", true)
				
                --break
            end
        end

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.StaticMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Beretta_C") and mesh:get_fname():to_string() == "MagazineMesh" then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
                Fpmesh:call("SetRenderInMainPass", true)
				Fpmesh:call("SetVisibility", true)
				
                break
            end
        end

end

function EShotgun()

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Shotgun1_C") and string.find(mesh:get_full_name(), "PersistentLevel") then
                SGmesh = mesh
                --print(SGmesh:get_full_name())
				SGmesh.RelativeRotation.Yaw = 0.0
                SGmesh:call("SetRenderInMainPass", true)
				SGmesh:call("SetVisibility", true)
				
                --break
            end
        end

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.StaticMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Shotgun1_C") and mesh:get_fname():to_string() == "MagazineMesh" then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
                Fpmesh:call("SetRenderInMainPass", true)
				Fpmesh:call("SetVisibility", true)
				
                --break
            end
        end
end

function DEShotgun()

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Shotgun1_C") and string.find(mesh:get_full_name(), "PersistentLevel") then
                SGmesh = mesh
                --print(SGmesh:get_full_name())
				--SGmesh.RelativeRotation.Yaw = 0.0
				SGmesh:call("SetVisibility", false)
                SGmesh:call("SetRenderInMainPass", false)
				
				
                --break
            end
        end

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.StaticMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Shotgun1_C") and mesh:get_fname():to_string() == "MagazineMesh" then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
                Fpmesh:call("SetRenderInMainPass", false)
				Fpmesh:call("SetVisibility", false)
				
                --break
            end
        end
end

function CSRev()
		local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SceneComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Revolver_C") and mesh:get_fname():to_string() == "DefaultSceneRoot" then
                CSEmesh = mesh
				--print("CSGlock")
				CSEmesh.RelativeRotation.Pitch = 0.0
				CSEmesh.RelativeRotation.Roll = 0.0
				CSEmesh.RelativeRotation.Yaw = 90.0
                CSEmesh.RelativeLocation.X = 0.0
				CSEmesh.RelativeLocation.Y = 0.0
				CSEmesh.RelativeLocation.Z = 0.0
				
                break
            end
        end
end

function ERev()

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Revolver_C") and string.find(mesh:get_full_name(), "PersistentLevel") then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
				if CutActive == true 
				then
					Fpmesh.RelativeRotation.Yaw = 0.0
				else	
					Fpmesh.RelativeRotation.Yaw = -90.0
				end
                Fpmesh:call("SetRenderInMainPass", true)
				Fpmesh:call("SetVisibility", true)
				
                --break
            end
        end

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.StaticMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Revolver_C") and mesh:get_fname():to_string() == "MagazineMesh" then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
                Fpmesh:call("SetRenderInMainPass", true)
				Fpmesh:call("SetVisibility", true)
				
                --break
            end
        end
end

function DERev()

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Revolver_C") and string.find(mesh:get_full_name(), "PersistentLevel") then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
				Fpmesh.RelativeRotation.Yaw = 0.0
                Fpmesh:call("SetRenderInMainPass", false)
				Fpmesh:call("SetVisibility", false)
				
                --break
            end
        end

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.StaticMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if string.find(mesh:get_full_name(), "BP_Revolver_C") and mesh:get_fname():to_string() == "MagazineMesh" then
                Fpmesh = mesh
                --print(Fpmesh:get_full_name())
                Fpmesh:call("SetRenderInMainPass", false)
				Fpmesh:call("SetVisibility", false)
				
                --break
            end
        end
end

function EDID()
	if Doonce5 == false then
		DIDON = true
		Doonce5 = true
		Doonce6 = false

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(true)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
        if mesh:get_fname():to_string() == "CharacterMesh0" then
            if string.find(mesh:get_full_name(), "PersistentLevel.BP_Liev_") or string.find(mesh:get_full_name(), "PersistentLevel.BP_Samuel_") or string.find(mesh:get_full_name(), "PersistentLevel.BP_Raven_") then
                --print("found char " .. mesh:get_full_name())
                Cmesh = mesh

                Cmesh:call("SetVisibility", true)
				Cmesh:call("SetRenderInMainPass", false)

                --break
            else
            end
        end
        end
        
        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if mesh:get_fname():to_string() == "DID" then
                --print("found did " .. mesh:get_full_name())
                Fpmesh = mesh
                Fpmesh:call("SetRenderInMainPass", true)
				Fpmesh:call("SetVisibility", true)
                --break
            end
        end

        local skeletal_mesh_c = api:find_uobject("Class /Script/UMG.WidgetComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if mesh:get_fname():to_string() == "DIDScreen" then
                --print("found DIDScreen " .. mesh:get_full_name())
                Fpmesh = mesh
                Fpmesh:call("SetRenderInMainPass", true)
				Fpmesh:call("SetVisibility", true)
                --break
            end
        end
	end
end

function DeDID()
local IsSC = Pawn:get_property("IsInCutscene")

	if IsSC == true 
		then
			--print("Waiting for Cut")
		else
	if Doonce6 == false then
		DIDON = false
		Doonce6 = true
        
        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if mesh:get_fname():to_string() == "DID" then
                --print("found Mag " .. mesh:get_full_name())
                DIDmesh = mesh
                DIDmesh:call("SetRenderInMainPass", false)
				DIDmesh:call("SetVisibility", false)
                --break
            end
        end

        local skeletal_mesh_c = api:find_uobject("Class /Script/UMG.WidgetComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
            if mesh:get_fname():to_string() == "DIDScreen" then
                --print("found DIDScreen " .. mesh:get_full_name())
                Fpmesh = mesh
                Fpmesh:call("SetRenderInMainPass", false)
				Fpmesh:call("SetVisibility", false)
                --break
            end
        end
		end

        local skeletal_mesh_c = api:find_uobject("Class /Script/Engine.SkeletalMeshComponent")
        if skeletal_mesh_c == nil then print("skeletal_mesh_c is nil") end

        local skeletal_meshes = skeletal_mesh_c:get_objects_matching(true)

        local mesh = nil
        for i, mesh in ipairs(skeletal_meshes) do
        if mesh:get_fname():to_string() == "CharacterMesh0" then
            if string.find(mesh:get_full_name(), "PersistentLevel.BP_Liev_") or string.find(mesh:get_full_name(), "PersistentLevel.BP_Samuel_") or string.find(mesh:get_full_name(), "PersistentLevel.BP_Raven_") then
                --print("found Character " .. mesh:get_full_name())
                Cmesh = mesh
                Cmesh:call("SetRenderInMainPass", false)
                Cmesh:call("SetVisibility", false)

                --break
            else
            end
        end
        end
end		
end

function FTCam()
--print("Waiting to apply Camera Mod")
	local ftpawn = api:get_local_pawn(0)

	Dobody2 = false
	CSHideBody()
	ftpawn.bFindCameraComponentWhenViewTarget = false
end

function CutCam()
    local HeadInstances = FindAllOf("SkeletalMeshComponent")
    if not HeadInstances then
    else
    for Index, HeadInstances in pairs(HeadInstances) do
        for matchedText in string.gmatch(HeadInstances:GetFullName(), ".CharacterMesh0") do
            GetHead = HeadInstances:GetFullName():sub(23)
            if string.find(GetHead, "Enemy") then
            else
                local ins_manager = StaticFindObject(GetHead)
                ins_manager.RelativeLocation = {X=-40, Y=-10, Z=-98}
            end
        end
    end
    end
end

function IntroCutCam()
	params.vr.set_mod_value("VR_CameraForwardOffset", "-31.177")
end

function GunCheck()
	Gunone = false
end

function CSdetect()
    
	if acuts_not_hooked then
    RegisterHook("/Game/DAYMARE/Code/Core/Manager/BP_CinematicManager.BP_CinematicManager_C:StartCutscene", function (Context)
		--print("Cut Started")
		CutActive = true
		ISCOnce = false
		if EndStarted ~= true then
		params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
		end
		if string.find(Pawn:get_full_name(), "Raven") and string.find(Pawn:get_full_name(), "Downtown") or string.find(Pawn:get_full_name(), "Sewer")
		then
			--print("Raven Downtown/Sewer Level")
        else
			CutCam()
        end
		
		UEVR_UObjectHook.set_disabled(true)
		CSMP5()
		CSGlock()
		CSRev()
        params.vr.set_aim_method(0)
		Dobody = false
		CSShowBody()
        Dobody2 = false
		IsHallucinating = Pawn:get_property("Hallucinating")
		if IsHallucinating == false then
		--params.vr.set_mod_value("VR_CustomZNear", "25.00")
		params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
		end
    end)
	RegisterHook("/Game/DAYMARE/Code/Core/Manager/BP_CutsceneWidget.BP_CutsceneWidget_C:SetupVideo", function (Context)
		--print("Cut2 Started")
		CutActive = true
		CutCam()
		UEVR_UObjectHook.set_disabled(true)
        params.vr.set_aim_method(0)
		CSShowBody()
        Dobody2 = false
		params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
    end)
    RegisterHook("/Game/DAYMARE/Code/Core/Manager/BP_CinematicManager.BP_CinematicManager_C:OnEndCut", function (Context)
		params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
		params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
		LevelStart = false
		CutActive = false
		IntroCutOnce = true
		InIntroCut = false
		UEVR_UObjectHook.set_disabled(false)
		CSHideBody()
        Dobody = false
        if EndStarted ~= true then
        params.vr.set_aim_method(2)
		ResetPlayUI()
		end
		--print("End Cut")
		ActiveWeap = "None"
		Weapset = false
		DeDID()
		
    end)
	
	RegisterHook("/Game/DAYMARE/Code/Core/Manager/BP_CinematicManager.BP_CinematicManager_C:PauseCutScene", function (Context)
		IsStartCut = Pawn:get_property("IsInCutscene")
		params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
		if GrabActive == false and IsStartCut == false and DIDON == false then
		params.vr.set_aim_method(2)
		--print("Pause Aim Changed")
		end
    end)
	
	RegisterHook("/Game/DAYMARE/Code/Core/Manager/BP_CinematicManager.BP_CinematicManager_C:SkipCutscene", function (Context)
		--print("Cut Skipped")
		params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
		params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
		LevelStart = false
		CutActive = false
		IntroCutOnce = true
		InIntroCut = false
		UEVR_UObjectHook.set_disabled(false)
		ActiveWeap = "None"
		Weapset = false
		CSHideBody()
        Dobody = false
		if EndStarted == true then
        params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
		end
		if EndStarted ~= true then
        params.vr.set_aim_method(2)
		ResetPlayUI()
		end
		DeDID()
		
    end)
    RegisterHook("/Game/DAYMARE/Code/Core/Puzzles/BP_triggerEnvInteraction.BP_TriggerEnvInteraction_C:DeactivateTrigger", function (Context)
		CutActive = true
		UEVR_UObjectHook.set_disabled(true)
		HideAllWeap()
        params.vr.set_aim_method(0)
		Dobody2 = false
		--print("DeactivateTrigger")
    end)
    RegisterHook("/Game/DAYMARE/Code/Core/Puzzles/BP_triggerEnvInteraction.BP_TriggerEnvInteraction_C:DeactivateInteract", function (Context)
		CutActive = false
        CSHideBody()
        Dobody = false
		UEVR_UObjectHook.set_disabled(false)
		ActiveWeap = "None"
		Weapset = false
        params.vr.set_aim_method(2)
		--print("DeactivateInteract")
		DeDID()
    end)
	
	RegisterHook("/Game/DAYMARE/Code/Core/Inventory/Code/FileObjects/BP_DocumentFile.BP_DocumentFile_C:Interact", function (Context)
		Reading = true
		CutActive = true
		Interacting = false
		params.vr.set_aim_method(2)
		params.vr.set_mod_value("VR_DPadShiftingMethod", "3")
		--print("Reading Doc")
    end)
	RegisterHook("/Game/DAYMARE/Code/Core/Inventory/Code/FileObjects/BP_DocumentFile.BP_DocumentFile_C:AfterInteract", function (Context)
		Reading = false
		CutActive = false
		params.vr.set_aim_method(2)
		params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
		--print("End Reading")
    end)
    acuts_not_hooked = false
	end
end

function EndScene()
if endscene_not_hooked then	
	local esa = StaticFindObject("/Game/DAYMARE/Code/Core/Puzzles/Kuronosu/BP_KuronosuPCNew.BP_KuronosuPCNew_C:Interact")
	if esa:IsValid() then	
		RegisterHook("/Game/DAYMARE/Code/Core/Puzzles/Kuronosu/BP_KuronosuPCNew.BP_KuronosuPCNew_C:Interact", function (Context)
		EndStarted = true
		EndPCPlayed = true
		--print("END PC Interact")
		params.vr.set_mod_value("UI_Distance", "0.690")
		params.vr.set_mod_value("UI_Size", "0.500")
		params.vr.set_mod_value("UI_X_Offset", "0.00")
		params.vr.set_mod_value("UI_Y_Offset", "0.100")
		params.vr.set_mod_value("VR_CameraForwardOffset", "-38.00")
		params.vr.set_mod_value("VR_CameraUpOffset", "7.517")
		params.vr.set_aim_method(0)
		end)
		endscene_not_hooked = false
	else
		EndStarted = false
	end
end	
if endscene_not_hooked then
	local esa = StaticFindObject("/Game/DAYMARE/Code/Core/Puzzles/Kuronosu/BP_KuronosuPCWidget.BP_KuronosuPCWidget_C:Start")
	if esa:IsValid() then
		endscene_not_hooked = false
		RegisterHook("/Game/DAYMARE/Code/Core/Puzzles/Kuronosu/BP_KuronosuPCWidget.BP_KuronosuPCWidget_C:Start", function (Context)
		EndStarted = true
		EndPCPlayed = true
		--print("END PC Interact")
		params.vr.set_mod_value("UI_Distance", "0.690")
		params.vr.set_mod_value("UI_Size", "0.500")
		params.vr.set_mod_value("UI_X_Offset", "0.00")
		params.vr.set_mod_value("UI_Y_Offset", "0.100")
		params.vr.set_mod_value("VR_CameraForwardOffset", "-38.00")
		params.vr.set_mod_value("VR_CameraUpOffset", "7.517")
		params.vr.set_aim_method(0)
		end)
	else
		EndStarted = false
	end
end

end

function MGdetect()
    
	if mgcut_not_hooked then
    RegisterHook("/Game/DAYMARE/Code/Core/Puzzles/BP_GenericMinigameObject.BP_GenericMinigameObject_C:Interact", function (Context)
		--print("MG Interact")
        params.vr.set_aim_method(0)
    end)

	RegisterHook("/Game/DAYMARE/Code/Core/Puzzles/BP_EnvInteract.BP_EnvInteract_C:Interact", function (Context)
		--print("ENV Interact")
		HideAllWeap()
        params.vr.set_aim_method(0)
    end)

	RegisterHook("/Game/DAYMARE/Code/Core/Terminal/BP_Terminal.BP_Terminal_C:EndOpen", function (Context)
		params.vr.set_aim_method(0)
		HideAllWeap()
    end)

    mgcut_not_hooked = false
	end
end

function DIDdetect()
    
	if did_not_hooked then
    RegisterHook("/Game/DAYMARE/Code/Core/Characters/BP_GenericPlayer.BP_GenericPlayer_C:BlendDIDCamera", function (Context)
		--print("Activate DID")
		DidOffsets()
		params.vr.set_mod_value("VR_DPadShiftingMethod", "3")
		params.vr.set_aim_method(0)
		EDID()
		Doonce5 = false
    end)
    RegisterHook("/Game/DAYMARE/Code/Core/Characters/BP_GenericPlayer.BP_GenericPlayer_C:DeactivateTickDID", function (Context)
		DidMode = "None"
		DidCloseOffsets()
		if MGActive == false then
		params.vr.set_aim_method(2)
		end
		--print("Deactivate DID")
		DeDID()
		params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
    end)
	
	RegisterHook("/Game/DAYMARE/Code/Core/Inventory/Graphics/BP/BP_DIDCommand.BP_DIDCommand_C:ShowMap", function (Context)
		DidMode = "Map"
		params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
    end)
	
	RegisterHook("/Game/DAYMARE/Code/Core/Inventory/Code/FileObjects/BP_AudioFile.BP_AudioFile_C:Use", function (Context)
		DidMode = "Aud"
		params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
    end)
	RegisterHook("/Game/DAYMARE/Code/Core/Inventory/Graphics/BP/BP_Documents.BP_Documents_C:OnAudioFinishedPlay", function (Context)
		params.vr.set_mod_value("VR_DPadShiftingMethod", "3")
    end)
	
	RegisterHook("/Game/DAYMARE/Code/Core/Inventory/Graphics/BP/BP_DIDCommand.BP_DIDCommand_C:ShowInv", function (Context)
		DidMode = "Inv"
		params.vr.set_mod_value("VR_DPadShiftingMethod", "3")
    end)
	RegisterHook("/Game/DAYMARE/Code/Core/Inventory/Graphics/BP/BP_DIDCommand.BP_DIDCommand_C:ShowStatus", function (Context)
		DidMode = "Stat"
		params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
    end)
	RegisterHook("/Game/DAYMARE/Code/Core/Inventory/Graphics/BP/BP_DIDCommand.BP_DIDCommand_C:ShowDocs", function (Context)
		DidMode = "Docs"
		params.vr.set_mod_value("VR_DPadShiftingMethod", "3")
    end)
	
	RegisterHook("/Game/DAYMARE/Code/Core/Tutorials/BP_NavigableTutorial.BP_NavigableTutorial_C:Show", function (Context)
		local tutpawn = api:get_local_pawn(0)
		local IsTut = tutpawn:get_property("Tutorial")
		if IsTut == true then
		--print("Am I Being Activated")
		Tutorial_Active = true
		params.vr.set_mod_value("VR_DPadShiftingMethod", "3")
		end
    end)
	RegisterHook("/Game/DAYMARE/Code/Core/Tutorials/BP_NavigableTutorial.BP_NavigableTutorial_C:CloseTutorial", function (Context)
		local tutpawn = api:get_local_pawn(0)
		local IsTut = tutpawn:get_property("Tutorial")
		--print("Tut Deactivated")
		Tutorial_Active = false
		params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
    end)
    did_not_hooked = false
	end
end

function Menudetect()
    
	if md_not_hooked then
    RegisterHook("/Game/DAYMARE/Code/Core/PlayerController/PC_MainPlayer.PC_MainPlayer_C:ShowPauseMenu", function (Context)
		IsStartCut = Pawn:get_property("IsInCutscene")
		params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
		PauseOffsets()
		if GrabActive == false and IsStartCut == false and DIDON == false and SGActive == false and MGActive == false and HEXActive == false then
		params.vr.set_aim_method(2)
		end
		--print("Hi Clare")
    end)
	
    RegisterHook("/Game/DAYMARE/Code/Core/Menu/BP/BP_PauseScreen.BP_PauseScreen_C:BndEvt__ResumeButton_K2Node_ComponentBoundEvent_448_OnButtonClickedEvent__DelegateSignature", function (Context)
		if MGActive == true then
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			ResumePauseOffsets()
		elseif DIDON == true and DidMode == "Inv" or DidMode == "Docs" then
			DidOffsets()
			params.vr.set_mod_value("VR_DPadShiftingMethod", "3")
		else
			params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
		end
    end)
	RegisterHook("/Game/DAYMARE/Code/Core/Menu/BP/BP_PauseScreen.BP_PauseScreen_C:SpecialRightPressed", function (Context)
		if MGActive == true then
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			ResumePauseOffsets()
		elseif DIDON == true and DidMode == "Inv" or DidMode == "Docs" then
			DidOffsets()
			params.vr.set_mod_value("VR_DPadShiftingMethod", "3")
		else
			params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
		end
		--print("FB")
    end)
	RegisterHook("/Game/DAYMARE/Code/Core/Menu/BP/BP_PauseScreen.BP_PauseScreen_C:FaceRightPressed", function (Context)

			if MGActive == true then
				params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
				ResumePauseOffsets()
			elseif DIDON == true and DidMode == "Inv" or DidMode == "Docs" then
				DidOffsets()
				params.vr.set_mod_value("VR_DPadShiftingMethod", "3")
			else
				params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
			end

		--print("Back")
    end)
    RegisterHook("/Game/DAYMARE/Code/Core/Menu/BP/BP_PauseScreen.BP_PauseScreen_C:EscPressed", function (Context)
		if MGActive == true then
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			ResumePauseOffsets()
		elseif DIDON == true and DidMode == "Inv" or DidMode == "Docs" then
			DidOffsets()
			params.vr.set_mod_value("VR_DPadShiftingMethod", "3")
		else
			params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
		end
		--print("Esc")
    end)
	
	RegisterHook("/Game/DAYMARE/Code/Core/Menu/BP/BP_PauseScreen.BP_PauseScreen_C:BndEvt__ResumeButton_K2Node_ComponentBoundEvent_518_CallbackPressed__DelegateSignature", function (Context)
		if MGActive == true then
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			ResumePauseOffsets()
		elseif DIDON == true and DidMode == "Inv" or DidMode == "Docs" then
			DidOffsets()
			params.vr.set_mod_value("VR_DPadShiftingMethod", "3")
		else
			params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
		end
		--print("Resume")
    end)
	
    RightControl()
    md_not_hooked = false
	end
end

function GrabStable()
		local HeadClass = api:find_uobject("Class /Script/Engine.CameraAnimInst")
        local HeadInstances = HeadClass:get_objects_matching(false)
        for Index, HeadInstances in pairs(HeadInstances) do
		local isset = tostring(HeadInstances.PlayRate)
		HeadInstances.PlayRate = "0.0"
        end
end

function GrabDetect()
if grab_not_hooked then
	RegisterHook("/Game/DAYMARE/Code/Core/Characters/BP_GenericPlayer.BP_GenericPlayer_C:OnEnemyGrab", function (Context)
		--print("OEG")
		GrabActive = true
		Dobody = false
		CSShowBody()
		Dobody2 = false
		UEVR_UObjectHook.set_disabled(true)
		params.vr.set_aim_method(0)
		GrabStable()
		Death()
    end)
    RegisterHook("/Game/DAYMARE/Code/Core/PlayerController/PC_MainPlayer.PC_MainPlayer_C:EndGrab", function (Context)
		--print("End Grab")
		GrabActive = false
		CSHideBody()
		Dobody = false
		UEVR_UObjectHook.set_disabled(false)
		params.vr.set_aim_method(2)
    end)
    
	grab_not_hooked = false
	end
end

function RightControl()
	RegisterHook("/Game/DAYMARE/Code/Core/PlayerController/PC_MainPlayer.PC_MainPlayer_C:InpActEvt_ShowRecapStats_K2Node_InputActionEvent_14", function (Context)
		params.vr.set_mod_value("VR_DPadShiftingMethod", "3")
    end)
	RegisterHook("/Game/DAYMARE/Code/Core/PlayerController/PC_MainPlayer.PC_MainPlayer_C:InpActEvt_ShowRecapStats_K2Node_InputActionEvent_15", function (Context)
		params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
    end)
end

function Death()
if DeathHook == false then
	local deathfound = StaticFindObject("/Game/DAYMARE/Code/Core/Menu/BP/BP_DeathScreen.BP_DeathScreen_C:BndEvt__LoadCheckpoint_K2Node_ComponentBoundEvent_42_CallbackPressed__DelegateSignature")
	if deathfound:IsValid() then
	DeathHook = true
	RegisterHook("/Game/DAYMARE/Code/Core/Menu/BP/BP_DeathScreen.BP_DeathScreen_C:BndEvt__LoadCheckpoint_K2Node_ComponentBoundEvent_42_CallbackPressed__DelegateSignature", function (Context)
		--print("Death Continue")
		IsDead = true
        params.vr.set_aim_method(2)
    end)
	RegisterHook("/Game/DAYMARE/Code/Core/Characters/BP_GenericPlayer.BP_GenericPlayer_C:OnEnemyInstantKill", function (Context)
		--print("LievBoss")
		GrabActive = true
        CSShowBody()
        Dobody2 = false
		UEVR_UObjectHook.set_disabled(true)
        params.vr.set_aim_method(0)
		GrabStable()
    end)
	RegisterHook("/Game/DAYMARE/Code/Core/Menu/BP/BP_DeathScreen.BP_DeathScreen_C:StartAnimDeathScreen", function (Context)
		GrabActive = false
		--print("Instant Death")
		Ideath = true
        params.vr.set_aim_method(0)
		params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
    end)
	end
end	
end

function Cam()
	FTCam()
	
	ExecuteWithDelay(300, IntroCutCheck)
	--print("Cam Applied")
end

function IntroCutCheck()
    IsStartCut = Pawn:get_property("IsInCutscene")
	if IsStartCut == true 
		then
			CutActive = true
			ISCOnce = false
			Dobody = false
			CSShowBody()
			params.vr.set_aim_method(0)
			IntroCutCam()
			--print("Intro Cut ShowBody")
		else
			CutActive = false
			UEVR_UObjectHook.set_disabled(false)
			params.vr.set_aim_method(2)
			params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
			DeDID()
			--print("Play HideBody")
	end
end

function WeaponCheck()
		local wPawn = Pawn:get_full_name()
		local ins_manager = StaticFindObject("/Game/MAPS/Persistent/DM_Persistent.DM_Persistent:PersistentLevel.PC_MainPlayer_C_0")
		local primary = ins_manager.PrimaryWeaponEquipped
		local secondary = ins_manager.SecondaryWeaponEquipped
		local tertiary = ins_manager.TertiaryWeaponEquipped
		if primary == true then
		ActiveWeap = "Pri"
		if string.find(wPawn, "Liev") then
		EGlock()
		DeMP5()
		end
		if string.find(wPawn, "Samuel") then
		EGlock()
		DEShotgun()
		DERev()
		end
		if string.find(wPawn, "Raven") then
		EBur()
		DEShotgun()
		DeDEagle()
		end	
	elseif secondary == true then
		ActiveWeap = "Sec"
		if string.find(wPawn, "Liev") then
		EMP5()
		DeGlock()
		end
		if string.find(wPawn, "Samuel") then
		EShotgun()
		DeGlock()
		DERev()
		end
		if string.find(wPawn, "Raven") then
		EShotgun()
		DeBur()
		DeDEagle()
		end		
	elseif tertiary == true then
		ActiveWeap = "Ter"
		if string.find(wPawn, "Samuel") then
		ERev()
		DEShotgun()
		DeGlock()
		end
		if string.find(wPawn, "Raven") then
		EDEagle()
		DEShotgun()
		DeBur()
		end
	else
		ActiveWeap = "None"
		DeMP5()
		DEShotgun()
		DERev()
		DeGlock()
		DeDEagle()
		DeBur()
	end
end

function DidOffsets()
	params.vr.set_mod_value("UI_Distance", "0.300")
	params.vr.set_mod_value("UI_Size", "0.300")
	params.vr.set_mod_value("UI_X_Offset", "-0.05")
	params.vr.set_mod_value("UI_Y_Offset", "0.00")
end

function DidCloseOffsets()
	params.vr.set_mod_value("UI_Distance", "4.500")
	params.vr.set_mod_value("UI_Size", "3.60")
	params.vr.set_mod_value("UI_X_Offset", "0.00")
	params.vr.set_mod_value("UI_Y_Offset", "0.00")
end

function PauseOffsets()
	if FunBegin == true or LockActive == true or PcActive == true or FountainBegin == true or SGActive == true or NitroBegin == true or SakBegin == true or MpcBegin == true or SpcBegin == true or WPBegin == true or MGActive == true then
	params.vr.set_mod_value("UI_Distance", "4.500")
	params.vr.set_mod_value("UI_Size", "3.60")
	params.vr.set_mod_value("UI_X_Offset", "0.00")
	params.vr.set_mod_value("UI_Y_Offset", "0.00")
	end
end

function ResumePauseOffsets()
	if FunBegin == true or LockActive == true or PcActive == true or FountainBegin == true or SGActive == true or NitroBegin == true or SakBegin == true or MpcBegin == true or SpcBegin == true or WPBegin == true or MGActive == true then
		InteractionOffsets()
	end
end

function InteractionOffsets()
		CurInt = Pawn:get_property("InteractingObject")
		if string.find(CurInt:get_full_name(), "HexacoreTerminal") or string.find(CurInt:get_full_name(), "HIVEHospital") then
			--print("Hex Interact")
			HEXActive = true
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			HideAllWeap()
			params.vr.set_mod_value("UI_Distance", "0.500")
			params.vr.set_mod_value("UI_Size", "0.785")
			params.vr.set_mod_value("VR_CameraForwardOffset", "-13.614")
			params.vr.set_aim_method(0)
		elseif string.find(CurInt:get_full_name(), "FunicolarLever") then
			--print("Funicolar Interact")
			FunBegin = true
			HideAllWeap()
			params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
			params.vr.set_mod_value("UI_Distance", "1.30")
			params.vr.set_mod_value("UI_Size", "2.50")
			params.vr.set_mod_value("UI_X_Offset", "-0.40")
			params.vr.set_mod_value("UI_Y_Offset", "0.40")
			params.vr.set_mod_value("VR_CameraForwardOffset", "-81.80")
			params.vr.set_mod_value("VR_CameraUpOffset", "47.00")
		elseif string.find(CurInt:get_full_name(), "BP_FunicolarPuzzle_C") then
			--print("Funicolar Puzzle Interact")
			FunBegin = true
			HideAllWeap()
			params.vr.set_mod_value("UI_Distance", "0.680")
			params.vr.set_mod_value("UI_Size", "1.255")
			params.vr.set_mod_value("UI_X_Offset", "-0.20")
			params.vr.set_mod_value("UI_Y_Offset", "0.00")
		elseif string.find(CurInt:get_full_name(), "LockDoor") or string.find(CurInt:get_full_name(), "DoorLocker") then
			--print("Lock Interact")
			LockActive = true
			HideAllWeap()
			params.vr.set_mod_value("UI_Distance", "0.50")
			params.vr.set_mod_value("UI_Size", "0.50")
			params.vr.set_mod_value("UI_X_Offset", "-0.20")
			params.vr.set_mod_value("UI_Y_Offset", "0.00")
			params.vr.set_mod_value("VR_CameraForwardOffset", "-26.50")
			params.vr.set_mod_value("VR_CameraUpOffset", "18.80")
		elseif string.find(CurInt:get_full_name(), "NitrogenGenerator") then
			--print("Nitro Interact")
			NitroBegin = true
			HideAllWeap()
			params.vr.set_mod_value("UI_Distance", "0.500")
			params.vr.set_mod_value("UI_Size", "1.070")
			params.vr.set_mod_value("UI_X_Offset", "-0.300")
			params.vr.set_mod_value("VR_CameraForwardOffset", "-22.270")
			params.vr.set_mod_value("VR_CameraUpOffset", "15.00")
		elseif string.find(CurInt:get_full_name(), "PCServerMan") then
			--print("PC Interact")
			PcActive = true
			HideAllWeap()
			params.vr.set_mod_value("UI_Distance", "0.400")
			params.vr.set_mod_value("UI_Size", "0.690")
			params.vr.set_mod_value("UI_X_Offset", "-0.400")
			params.vr.set_mod_value("UI_Y_Offset", "0.200")
			params.vr.set_mod_value("VR_CameraForwardOffset", "-20.75")
			params.vr.set_mod_value("VR_CameraUpOffset", "10.30")
			UEVR_UObjectHook.set_disabled(true)
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			HideAllWeap()
			params.vr.set_aim_method(0)
		elseif string.find(CurInt:get_full_name(), "Column") then
			--print("Fountain Interact")
			FountainBegin = true
			HideAllWeap()
			params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
			params.vr.set_mod_value("UI_Distance", "1.640")
			params.vr.set_mod_value("UI_Size", "2.50")
			params.vr.set_mod_value("VR_CameraForwardOffset", "-117.50")
			--params.vr.set_mod_value("VR_CameraUpOffset", "43.15")
		elseif string.find(CurInt:get_full_name(), "SakamuraEnigma") then
			--print("Sakamura Interact")
			SakBegin = true
			HideAllWeap()
			params.vr.set_mod_value("UI_Distance", "1.355")
			params.vr.set_mod_value("UI_Size", "1.825")
			params.vr.set_mod_value("UI_X_Offset", "-0.40")
			params.vr.set_mod_value("VR_CameraUpOffset", "20.00")
		elseif string.find(CurInt:get_full_name(), "MorseCodePC") then
			--print("MorseCodePC Interact")
			MpcBegin = true
			HideAllWeap()
			params.vr.set_mod_value("UI_Distance", "0.785")
			params.vr.set_mod_value("UI_Size", "0.685")
			params.vr.set_mod_value("VR_CameraForwardOffset", "-12.75")
			params.vr.set_mod_value("VR_CameraUpOffset", "21.20")
		elseif string.find(CurInt:get_full_name(), "ScreenGen") then
			--print("Generator PC Interact")
			SGActive = true
			HideAllWeap()
			params.vr.set_mod_value("UI_Distance", "0.595")
			params.vr.set_mod_value("UI_Size", "1.070")
			params.vr.set_mod_value("UI_X_Offset", "-0.40")
			params.vr.set_mod_value("VR_CameraForwardOffset", "-30.00")
			params.vr.set_mod_value("VR_CameraUpOffset", "30.00")
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			HideAllWeap()
			params.vr.set_aim_method(0)
		elseif string.find(CurInt:get_full_name(), "SubSwitchPC") then
			--print("SubSwitch Interact")
			MGActive = true
			HideAllWeap()
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			params.vr.set_aim_method(0)
			params.vr.set_mod_value("UI_Distance", "0.500")
			params.vr.set_mod_value("UI_Size", "0.780")
			params.vr.set_mod_value("UI_X_Offset", "-0.300")
		elseif string.find(CurInt:get_full_name(), "SewerPC") then
			--print("SewerPC Interact")
			SpcBegin = true
			HideAllWeap()
			params.vr.set_mod_value("UI_Distance", "0.50")
			params.vr.set_mod_value("UI_Size", "0.80")
			params.vr.set_mod_value("UI_X_Offset", "-0.40")
			params.vr.set_mod_value("VR_CameraForwardOffset", "-7.50")
			params.vr.set_mod_value("VR_CameraUpOffset", "22.71")
		elseif string.find(CurInt:get_full_name(), "PompeDrenaggio") then
			--print("WirePuzzle Interact")
			WPBegin = true
			HideAllWeap()
			params.vr.set_mod_value("UI_Distance", "0.690")
			params.vr.set_mod_value("UI_Size", "1.070")
			params.vr.set_mod_value("UI_X_Offset", "-0.400")
			params.vr.set_mod_value("UI_Y_Offset", "0.200")
			params.vr.set_mod_value("VR_CameraForwardOffset", "-15.00")
		elseif string.find(CurInt:get_full_name(), "LievBossFight") then
			--print("Liev Boss")
			MGActive = true
			HideAllWeap()
		elseif string.find(CurInt:get_full_name(), "DirectorPuzzle") then
			--print("Director Puzzle Interact")
			MGActive = true
			HideAllWeap()
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			params.vr.set_aim_method(0)
			params.vr.set_mod_value("UI_Distance", "0.975")
			params.vr.set_mod_value("UI_Size", "0.880")
			params.vr.set_mod_value("UI_X_Offset", "-0.100")
			params.vr.set_mod_value("UI_Y_Offset", "0.400")
		elseif string.find(CurInt:get_full_name(), "BP_Generator_C") then
			--print("Generator Puzzle Interact")
			MGActive = true
			HideAllWeap()
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			params.vr.set_aim_method(0)
			params.vr.set_mod_value("UI_Distance", "1.165")
			params.vr.set_mod_value("UI_Size", "1.730")
			params.vr.set_mod_value("UI_X_Offset", "-0.50")
		elseif string.find(CurInt:get_full_name(), "BP_HexacoreArchive_C") then
			--print("Hex Archive Puzzle Interact")
			MGActive = true
			HideAllWeap()
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			params.vr.set_aim_method(0)
			params.vr.set_mod_value("UI_Distance", "0.50")
			params.vr.set_mod_value("UI_Size", "0.50")
			params.vr.set_mod_value("UI_X_Offset", "-0.20")
			params.vr.set_mod_value("UI_Y_Offset", "0.00")
		elseif string.find(CurInt:get_full_name(), "BP_FireExtinguisher_C") then
			--print("Fire Puzzle Interact")
			MGActive = true
			HideAllWeap()
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			params.vr.set_aim_method(0)
			params.vr.set_mod_value("UI_Distance", "0.975")
			params.vr.set_mod_value("UI_Size", "1.825")
			params.vr.set_mod_value("UI_X_Offset", "-0.60")
			params.vr.set_mod_value("UI_Y_Offset", "0.00")
		elseif string.find(CurInt:get_full_name(), "BP_ElectricPad_C") then
			--print("Elec Puzzle Interact")
			MGActive = true
			HideAllWeap()
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			params.vr.set_aim_method(0)
			params.vr.set_mod_value("UI_Distance", "0.300")
			params.vr.set_mod_value("UI_Size", "0.500")
			params.vr.set_mod_value("UI_X_Offset", "-0.10")
			params.vr.set_mod_value("UI_Y_Offset", "0.00")	
		elseif string.find(CurInt:get_full_name(), "BP_KeypadObject_C") then
			--print("Keypad Interact")
			MGActive = true
			HideAllWeap()
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			params.vr.set_aim_method(0)	
			params.vr.set_mod_value("UI_Distance", "0.690")
			params.vr.set_mod_value("UI_Size", "0.975")
		elseif string.find(CurInt:get_full_name(), "BP_MorseAlpahbetPC_C") then
			--print("Morse Alphabet Interact")
			MGActive = true
			HideAllWeap()
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			params.vr.set_aim_method(0)
			params.vr.set_mod_value("UI_Distance", "0.595")
			params.vr.set_mod_value("UI_Size", "0.975")
			params.vr.set_mod_value("UI_X_Offset", "-0.40")
		elseif string.find(CurInt:get_full_name(), "BP_PCSarah_C") then
			--print("Morse Alphabet Interact")
			MGActive = true
			HideAllWeap()
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			params.vr.set_aim_method(0)	
			params.vr.set_mod_value("UI_Distance", "0.500")
			params.vr.set_mod_value("UI_Size", "0.975")
			params.vr.set_mod_value("UI_X_Offset", "-0.500")
			params.vr.set_mod_value("VR_CameraForwardOffset", "-11.55")
			params.vr.set_mod_value("VR_CameraUpOffset", "24.95")
		end
end

function HideAllWeap()
	DeMP5()
	DEShotgun()
	DERev()
	DeGlock()
	DeDEagle()
	DeBur()
end

function Init()
	params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
	params.vr.set_mod_value("UI_Distance", "4.500")
	params.vr.set_mod_value("UI_Size", "3.60")
	params.vr.set_mod_value("UI_X_Offset", "0.00")
	params.vr.set_mod_value("UI_Y_Offset", "0.00")
end

function ResetPlayUI()
	params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
	params.vr.set_mod_value("UI_Distance", "4.500")
	params.vr.set_mod_value("UI_Size", "3.60")
	params.vr.set_mod_value("UI_X_Offset", "0.00")
	params.vr.set_mod_value("UI_Y_Offset", "0.00")
	params.vr.set_mod_value("VR_CameraForwardOffset", "0.00")
	params.vr.set_mod_value("VR_CameraUpOffset", "0.00")
	params.vr.set_mod_value("VR_CameraRightOffset", "0.00")
end

if string.find(Pawn:get_full_name(), "FirstPersonCharacter") and EndStarted == false then
	EndScene()
end

CurInt = "None"
IsStartCut = Pawn:get_property("IsInCutscene")

IsHexInUse = Pawn:get_property("CanTakeInputGameMode")

if IsStartCut == true and ISCOnce == false then
	ISCOnce = true
	params.vr.set_aim_method(0)
else
	
	
local pcont = api:get_player_controller(0)
local IsInt = pcont:get_property("FullInteracting")
local IsInCut = pcont:get_property("CanSkipCutscene")
local IsBlock = pcont:get_property("BlockInput")
local IsWEquip = pcont:get_property("EquipWeapon")

if HEXActive == true then
	local hexpawn = api:get_local_pawn(0)
	local IsHex = hexpawn:get_property("CanTakeInputGameMode")
	if IsHex == false
	then
		
	else
		if Tutorial_Active == false then
		--print("Closing HEX")
		HEXActive = false
		InteractOnce = true
		end
	end	
end	

if IsInt == Interacting or IsStartCut == true then

else
    InteractOnce = true
end

if InteractOnce == true then
    if IsInt == true or CutActive == true
    then
        Interacting = true
		InteractionOffsets()
		
		MGActive = true
		Cmesh:call("SetVisibility", false)
        InteractOnce = false
		if Reading == true then
			params.vr.set_aim_method(2)
			--print("Reading")
		elseif IsHacking == true then
		
		else
			params.vr.set_aim_method(0)
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
        --print("Interacting")
		end
    else
        Interacting = false
        InteractOnce = false
		UEVR_UObjectHook.set_disabled(false)
		if HEXActive == false then
			if IsHexInUse == true then
			params.vr.set_aim_method(2)
			params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
			end
			if FunBegin == true or LockActive == true or PcActive == true or FountainBegin == true or SGActive == true or NitroBegin == true or SakBegin == true or MpcBegin == true or SpcBegin == true or WPBegin == true or MGActive == true then
			--print("PC/Fun/Lock END")
			FunBegin = false
			PcActive = false
			FountainBegin = false
			LockActive = false
			NitroBegin = false
			SakBegin = false
			MpcBegin = false
			SGActive = false
			SpcBegin = false
			WPBegin = false
			
			
			
			end
		end
		MGActive = false

		DeDID()
				
		Pconce = false
		FunBegin = false
		if HEXActive == false then
			WeaponCheck()
			ResetPlayUI()
			params.vr.set_aim_method(2)
			--print("Not Interacting")
		end	
    end
end


end

local isvisible = Cmesh.bVisible
local isdidvisible = DIDmesh.bVisible

if isdidvisible == true and DIDON == false and CutActive == false and GrabActive == false then
	DIDmesh:call("SetVisibility", false)
	if CurWeap ~= "Sec" then
	SGmesh:call("SetVisibility", false)
	end
end

if isvisible == true and DIDON == false and CutActive == false and GrabActive == false and MGActive == false and Ideath == false then
	Cmesh:call("SetVisibility", false)
	Doonce6 = false
	DeDID()
	if CurWeap == "Pri" then
		DeMP5()
		DEShotgun()
	elseif CurWeap == "Sec" then
		
	elseif CurWeap == "Ter" then
		DeMP5()
		DEShotgun()
	else
	end
end

if Gunone == false then

local wPawn = Pawn:get_full_name()
local ins_manager = StaticFindObject("/Game/MAPS/Persistent/DM_Persistent.DM_Persistent:PersistentLevel.PC_MainPlayer_C_0")
local primary = ins_manager.PrimaryWeaponEquipped
local secondary = ins_manager.SecondaryWeaponEquipped
local tertiary = ins_manager.TertiaryWeaponEquipped

if primary == true then
	CurWeap = "Pri"
elseif secondary == true then
	CurWeap = "Sec"
elseif tertiary == true then	
	CurWeap = "Ter"
else
	CurWeap = "None"
end	

if string.find(tostring(CurWeap), tostring(ActiveWeap)) then
	Weapset = true
else
    Weapset = false
end

if Weapset == true then
else
	if primary == true then
		ActiveWeap = "Pri"
		if string.find(wPawn, "Liev") then
		EGlock()
		DeMP5()
		end
		if string.find(wPawn, "Samuel") then
		EGlock()
		DEShotgun()
		DERev()
		end
		if string.find(wPawn, "Raven") then
		EBur()
		DEShotgun()
		DeDEagle()
		end	
	elseif secondary == true then
		ActiveWeap = "Sec"
		if string.find(wPawn, "Liev") then
		EMP5()
		DeGlock()
		end
		if string.find(wPawn, "Samuel") then
		EShotgun()
		DeGlock()
		DERev()
		end
		if string.find(wPawn, "Raven") then
		EShotgun()
		DeBur()
		DeDEagle()
		end		
	elseif tertiary == true then
		ActiveWeap = "Ter"
		if string.find(wPawn, "Samuel") then
		ERev()
		DEShotgun()
		DeGlock()
		end
		if string.find(wPawn, "Raven") then
		EDEagle()
		DEShotgun()
		DeBur()
		end
	else
		ActiveWeap = "None"
		DeMP5()
		DEShotgun()
		DERev()
		DeGlock()
		DeDEagle()
		DeBur()
	end
end

end


end)

LuaVR.sdk.callbacks.on_xinput_get_state(function(retval, user_index, state)

if (state ~= nil) then
	if CutActive == true or MGActive == true or Playing == false or EndStarted == true or Ideath == true then
		if state.Gamepad.bLeftTrigger ~= 0 and state.Gamepad.bRightTrigger ~= 0 then
			if JustCentered == false then
				JustCentered = true
				--print("Centered")
				params.vr.recenter_view()
				ExecuteWithDelay(1000,function()
					JustCentered = false
				end)
			end
		end
	end  
end

end)

LuaVR.sdk.callbacks.on_script_reset(function()
    Dodid = false
    Dodid2 = false
    Dobody = false
    Dobody2 = false
    Doonce = false
    Doonce2 = false
    Doonce3 = false
    Doonce4 = false
    Doonce5 = false
    Doonce6 = false
    runonce = true
end)

RegisterHook("/Game/DAYMARE/Code/Core/Menu/BP/BP_MainMenuFix.BP_MainMenuFix_C:LoadingDone", function (Context)
		--print("Main Menu Loaded")
		if EndPCPlayed == true then
			EndPCPlayed = false
		end	
		params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
		Playing = false
		ResetPlayUI()		
    end)

RegisterHook("/Game/DAYMARE/Code/Core/Menu/BP/BP_LoadingScreenFix.BP_LoadingScreenFix_C:SetLoadingScreen", function (Context)
		--print("Loading Done")
		params.vr.set_aim_method(0)
		LoadingDone = true
    end)
	RegisterHook("/Game/DAYMARE/Code/Core/Menu/BP/BP_LoadingScreenFix.BP_LoadingScreenFix_C:Get_ContinueKey_Visibility_0", function (Context)
		if LoadingDone == true then
		LevelStart = false
		--print("Waiting to Continue")
		params.vr.set_aim_method(0)
		ActiveWeap = "None"
		Weapset = false
		LoadingDone = false
		end
    end)

RegisterHook("/Game/DAYMARE/Code/Core/Menu/BP/BP_LoadingScreenFix.BP_LoadingScreenFix_C:OnLevelStart", function (Context)
		--print("Started")
		IsStartCut = Pawn:get_property("IsInCutscene")
		if IsStartCut == true 
		then
			params.vr.set_aim_method(0)
			--print("Start Cut Scene")
		else
			--print("Start Playing")
		end
		Playing = true
		ISCOnce = false
		
		ActiveWeap = "None"
		Weapset = false
		LevelStart = true
		Gunone = false
		Dodid = false
		Dodid2 = false
		Dobody = false
		Dobody2 = false
		Doonce = false
		Doonce2 = false
		Doonce3 = false
		Doonce4 = false
		Doonce5 = false
		Doonce6 = false
		PcActive = false
		Pconce = false
		isvisible = true
		DIDON = false
		CutActive = false
		GrabActive = false
		Ideath = false
		Interacting = false
        InteractOnce = false
		InIntroCut = false
		
		GunCheck()

        DIDdetect()
		
		EndStarted = false
		

		MGdetect()
		Cam()
		FTCam()
		
        Menudetect()
		GrabDetect()
		CSdetect()
		
		Doonce6 = false
		DeDID()

		Death()
    end)


RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(Context)
	ExecuteInGameThread(function()
	if CutActive == false then
		FTCam()
    end
	end)
end)

ExecuteWithDelay(5000,function()
	Init()
end)



