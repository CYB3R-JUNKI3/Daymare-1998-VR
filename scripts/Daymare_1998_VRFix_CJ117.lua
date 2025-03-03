--###############################
--# Daymare 1998 Vr Fix - CJ117 #
--###############################


local api = uevr.api
local params = uevr.params
local callbacks = params.sdk.callbacks

local mDown = false
local mUp = false
local offset = {}
local adjusted_offset = {}
local base_pos = { 0, 0, 0 }
local mAttack = false
local mDownC = 0
local mUpC = 0
local mDB = false
local base_dif = 0
local is_running = false
local is_scanning = false
local InitLocY = nil
local JustCentered = false
local hidearms = false
local Mactive = false
local Playing = false
local is_playing = false
local GetPawn = nil
local is_paused = nil
local is_t_paused = nil
local is_end_paused = nil
local is_m_paused = false
local is_disabled = false
local is_did = false
local TutSOnce = false
local NavSOnce = false
local TutCOnce = false
local TutOOnce = false
local options_blocked = true
local video_blocked = true
local tutorials_blocked = true
local freeze_pause = false
local CutActive = false
local EndStarted = false
local Tutorial_Active = false
local MGActive = false
local ActivateDID = false
local CurInt = nil
local seq_active = nil
local IsInt = false
local IsInCut = false
local IsBlock = false
local IsWEquip = false
local IsStartCut = false
local IsHexInUse = false
local Mp5 = nil
local Glock = nil
local Shotgun = nil
local Beretta = nil
local DesertEagle = nil
local Revolver = nil
local Mp5_m = nil
local Glock_m = nil
local Shotgun_m = nil
local Beretta_m = nil
local DesertEagle_m = nil
local Revolver_m = nil
local Mp5_r = nil
local Glock_r = nil
local Shotgun_r = nil
local Beretta_r = nil
local DesertEagle_r = nil
local Revolver_r = nil
local weap_sel = false
local weap_aim = false
local LockActive = false
local HEXActive = false
local FunBegin = false
local PcActive = false
local FountainBegin = false
local NitroBegin = false
local SakBegin = false
local MpcBegin = false
local SGActive = false
local SpcBegin = false
local WPBegin = false
local is_torch = false
local tut_active = nil
local loading_sc = false
local IsHallucinating = false
local isvisible = false
local torch_on = false
local DIDON = false
local GrabActive = false
local GrabEscape = false
local Ideath = false
local is_dead = false
local instant_dead = false
local end_pc_active = false
local end_recap_active = false
local Reading = false
local is_jogging = false
local jogging = false
local pinned = false
local cur_num = nil
local last_num = 0
local is_status = false

local function find_required_object(name)
	local obj = api:find_uobject(name)
	if not obj then
		error("Cannot find " .. name)
		return nil
	end

	return obj
end

local function reset_height()
	local base = UEVR_Vector3f.new()
	params.vr.get_standing_origin(base)
	local hmd_index = params.vr.get_hmd_index()
	local hmd_pos = UEVR_Vector3f.new()
	local hmd_rot = UEVR_Quaternionf.new()
	params.vr.get_pose(hmd_index, hmd_pos, hmd_rot)
	base.x = hmd_pos.x
	base.y = hmd_pos.y
	base.z = hmd_pos.z
	params.vr.set_standing_origin(base)
	if hmd_pos.y >= 0.4 then
		InitLocY = 0.30
	else
		InitLocY = -0.10
	end
end

local function WeaponCheck()
	local ins_manager = api:get_local_pawn(0)
	if ins_manager ~= nil and not string.find(ins_manager:get_full_name(), "Kuronosu") then
		local wPcont = api:get_player_controller(0)
		local primary = wPcont.PrimaryWeaponEquipped
		local secondary = wPcont.SecondaryWeaponEquipped
		local tertiary = wPcont.TertiaryWeaponEquipped
		local weapons = ins_manager.Weapons


		for i, mesh in ipairs(weapons) do
			if string.find(mesh:get_full_name(), "MP5") then
				Mp5 = mesh.SkeletalMesh
				Mp5_m = mesh.MagazineMesh
				Mp5_r = mesh.DefaultSceneRoot
			elseif string.find(mesh:get_full_name(), "Glock") then
				Glock = mesh.SkeletalMesh
				Glock_m = mesh.MagazineMesh
				Glock_r = mesh.DefaultSceneRoot
			elseif string.find(mesh:get_full_name(), "Shotgun") then
				Shotgun = mesh.SkeletalMesh
				Shotgun_m = mesh.MagazineMesh
				Shotgun_r = mesh.DefaultSceneRoot
			elseif string.find(mesh:get_full_name(), "Beretta") then
				Beretta = mesh.SkeletalMesh
				Beretta_m = mesh.MagazineMesh
				Beretta_r = mesh.DefaultSceneRoot
			elseif string.find(mesh:get_full_name(), "DesertEagle") then
				DesertEagle = mesh.SkeletalMesh
				DesertEagle_m = mesh.MagazineMesh
				DesertEagle_r = mesh.DefaultSceneRoot
			elseif string.find(mesh:get_full_name(), "Revolver") then
				Revolver = mesh.SkeletalMesh
				Revolver_m = mesh.MagazineMesh
				Revolver_r = mesh.DefaultSceneRoot
			end
		end


		ins_manager.PrimaryWeapon:call("SetRenderInMainPass", true)
		ins_manager.PrimaryWeapon:call("SetVisibility", true)

		ins_manager.SecondaryWeapon:call("SetRenderInMainPass", true)
		ins_manager.SecondaryWeapon:call("SetVisibility", true)

		ins_manager.TertiaryWeapon:call("SetRenderInMainPass", true)
		ins_manager.TertiaryWeapon:call("SetVisibility", true)
	end
end

local function CSShowBody()
	local dpawn = api:get_local_pawn(0)
	dpawn.Mesh:call("SetVisibility", true)
	dpawn.Mesh:call("SetRenderInMainPass", true)
end

local function CSHideBody()
	local dpawn = api:get_local_pawn(0)
	dpawn.Mesh:call("SetVisibility", false)
	dpawn.Mesh:call("SetRenderInMainPass", false)
end

local function CSMP5()
	local ins_manager = api:get_local_pawn(0)
	if not string.find(ins_manager:get_full_name(), "Kuronosu") then
		if ins_manager ~= nil and not string.find(ins_manager:get_full_name(), "Samuel") then
			local wPcont = api:get_player_controller(0)
			local primary = wPcont.PrimaryWeaponEquipped
			local secondary = wPcont.SecondaryWeaponEquipped
			local tertiary = wPcont.TertiaryWeaponEquipped
			local weapons = ins_manager.Weapons


			for i, mesh in ipairs(weapons) do
				if string.find(mesh:get_full_name(), "MP5") then
					Mp5 = mesh.SkeletalMesh
					Mp5_m = mesh.MagazineMesh
					Mp5_r = mesh.DefaultSceneRoot
				elseif string.find(mesh:get_full_name(), "Glock") then
					Glock = mesh.SkeletalMesh
					Glock_m = mesh.MagazineMesh
					Glock_r = mesh.DefaultSceneRoot
				elseif string.find(mesh:get_full_name(), "Shotgun") then
					Shotgun = mesh.SkeletalMesh
					Shotgun_m = mesh.MagazineMesh
					Shotgun_r = mesh.DefaultSceneRoot
				elseif string.find(mesh:get_full_name(), "Beretta") then
					Beretta = mesh.SkeletalMesh
					Beretta_m = mesh.MagazineMesh
					Beretta_r = mesh.DefaultSceneRoot
				elseif string.find(mesh:get_full_name(), "DesertEagle") then
					DesertEagle = mesh.SkeletalMesh
					DesertEagle_m = mesh.MagazineMesh
					DesertEagle_r = mesh.DefaultSceneRoot
				elseif string.find(mesh:get_full_name(), "Revolver") then
					Revolver = mesh.SkeletalMesh
					Revolver_m = mesh.MagazineMesh
					Revolver_r = mesh.DefaultSceneRoot
				end
			end

			if string.find(ins_manager:get_full_name(), "Harbor") then
				--print("CS MP5 Harbor")
				Mp5_r.RelativeRotation.Pitch = 0.0
				Mp5_r.RelativeRotation.Roll = 0.0
				Mp5_r.RelativeRotation.Yaw = 0.0
				Mp5_r.RelativeLocation.X = 0.0
				Mp5_r.RelativeLocation.Y = 0.0
				Mp5_r.RelativeLocation.Z = 0.0
			elseif not string.find(ins_manager:get_full_name(), "Raven") then
				--print("CS MP5")
				Mp5_r.RelativeRotation.Pitch = 0.0
				Mp5_r.RelativeRotation.Roll = 0.0
				Mp5_r.RelativeRotation.Yaw = 0.0
				Mp5_r.RelativeLocation.X = 0.0
				Mp5_r.RelativeLocation.Y = 0.0
				Mp5_r.RelativeLocation.Z = 0.0
			end
		end
		if string.find(ins_manager:get_full_name(), "Hospital") then
			--print("CS MP5 Harbor")
			Revolver_r.RelativeRotation.Pitch = 0.0
			Revolver_r.RelativeRotation.Roll = 0.0
			Revolver_r.RelativeRotation.Yaw = 0.0
			Revolver_r.RelativeLocation.X = 0.0
			Revolver_r.RelativeLocation.Y = 0.0
			Revolver_r.RelativeLocation.Z = 0.0
			Glock_r.RelativeRotation.Pitch = 0.0
			Glock_r.RelativeRotation.Roll = 0.0
			Glock_r.RelativeRotation.Yaw = 0.0
			Glock_r.RelativeLocation.X = 0.0
			Glock_r.RelativeLocation.Y = 0.0
			Glock_r.RelativeLocation.Z = 0.0
		elseif not string.find(ins_manager:get_full_name(), "FireWatcher") and not string.find(ins_manager:get_full_name(), "Raven") then
			--print("CS MP5")
			Revolver_r.RelativeRotation.Pitch = 0.0
			Revolver_r.RelativeRotation.Roll = 0.0
			Revolver_r.RelativeRotation.Yaw = 0.0
			Revolver_r.RelativeLocation.X = 0.0
			Revolver_r.RelativeLocation.Y = 0.0
			Revolver_r.RelativeLocation.Z = 0.0
			Glock_r.RelativeRotation.Pitch = 0.0
			Glock_r.RelativeRotation.Roll = 0.0
			Glock_r.RelativeRotation.Yaw = 0.0
			Glock_r.RelativeLocation.X = 0.0
			Glock_r.RelativeLocation.Y = 0.0
			Glock_r.RelativeLocation.Z = 0.0
		end
		if string.find(ins_manager:get_full_name(), "Outskirts") then
			--print("CS MP5 Harbor")
			DesertEagle_r.RelativeRotation.Pitch = 0.0
			DesertEagle_r.RelativeRotation.Roll = 0.0
			DesertEagle_r.RelativeRotation.Yaw = 0.0
			DesertEagle_r.RelativeLocation.X = 0.0
			DesertEagle_r.RelativeLocation.Y = 0.0
			DesertEagle_r.RelativeLocation.Z = 0.0
		end
	end
end

local function HideAllWeap()
	WeaponCheck()
	local dpawn = api:get_local_pawn(0)
	if dpawn ~= nil then
		if string.find(GetPawn, "Liev") then
			Mp5:call("SetRenderInMainPass", false)
			Mp5:call("SetVisibility", false)
			Glock:call("SetRenderInMainPass", false)
			Glock:call("SetVisibility", false)
			Revolver:call("SetRenderInMainPass", false)
			Revolver:call("SetVisibility", false)
			Mp5_m:call("SetRenderInMainPass", false)
			Mp5_m:call("SetVisibility", false)
			Glock_m:call("SetRenderInMainPass", false)
			Glock_m:call("SetVisibility", false)
			Revolver_m:call("SetRenderInMainPass", false)
			Revolver_m:call("SetVisibility", false)
		end
		if string.find(GetPawn, "Samuel") then
			Shotgun:call("SetRenderInMainPass", false)
			Shotgun:call("SetVisibility", false)
			Glock:call("SetRenderInMainPass", false)
			Glock:call("SetVisibility", false)
			Revolver:call("SetRenderInMainPass", false)
			Revolver:call("SetVisibility", false)
			Shotgun_m:call("SetRenderInMainPass", false)
			Shotgun_m:call("SetVisibility", false)
			Glock_m:call("SetRenderInMainPass", false)
			Glock_m:call("SetVisibility", false)
			Revolver_m:call("SetRenderInMainPass", false)
			Revolver_m:call("SetVisibility", false)
		end
		if string.find(GetPawn, "Raven") then
			Shotgun:call("SetRenderInMainPass", false)
			Shotgun:call("SetVisibility", false)
			Beretta:call("SetRenderInMainPass", false)
			Beretta:call("SetVisibility", false)
			DesertEagle:call("SetRenderInMainPass", false)
			DesertEagle:call("SetVisibility", false)
			Shotgun_m:call("SetRenderInMainPass", false)
			Shotgun_m:call("SetVisibility", false)
			Beretta_m:call("SetRenderInMainPass", false)
			Beretta_m:call("SetVisibility", false)
			DesertEagle_m:call("SetRenderInMainPass", false)
			DesertEagle_m:call("SetVisibility", false)
		end
	end
end

local function ShowAllWeap()
	WeaponCheck()
	local dpawn = api:get_local_pawn(0)
	if dpawn ~= nil then
		if string.find(GetPawn, "Liev") then
			Mp5:call("SetRenderInMainPass", true)
			Mp5:call("SetVisibility", true)
			Glock:call("SetRenderInMainPass", true)
			Glock:call("SetVisibility", true)
			Mp5_m:call("SetRenderInMainPass", true)
			Mp5_m:call("SetVisibility", true)
			Glock_m:call("SetRenderInMainPass", true)
			Glock_m:call("SetVisibility", true)
		end
		if string.find(GetPawn, "Samuel") then
			Shotgun:call("SetRenderInMainPass", true)
			Shotgun:call("SetVisibility", true)
			Glock:call("SetRenderInMainPass", true)
			Glock:call("SetVisibility", true)
			Revolver:call("SetRenderInMainPass", true)
			Revolver:call("SetVisibility", true)
			Shotgun_m:call("SetRenderInMainPass", true)
			Shotgun_m:call("SetVisibility", true)
			Glock_m:call("SetRenderInMainPass", true)
			Glock_m:call("SetVisibility", true)
			Revolver_m:call("SetRenderInMainPass", true)
			Revolver_m:call("SetVisibility", true)
		end
		if string.find(GetPawn, "Raven") then
			Shotgun:call("SetRenderInMainPass", true)
			Shotgun:call("SetVisibility", true)
			Beretta:call("SetRenderInMainPass", true)
			Beretta:call("SetVisibility", true)
			DesertEagle:call("SetRenderInMainPass", true)
			DesertEagle:call("SetVisibility", true)
			Shotgun_m:call("SetRenderInMainPass", true)
			Shotgun_m:call("SetVisibility", true)
			Beretta_m:call("SetRenderInMainPass", true)
			Beretta_m:call("SetVisibility", true)
			DesertEagle_m:call("SetRenderInMainPass", true)
			DesertEagle_m:call("SetVisibility", true)
		end
	end
end

local function EDID()
	DIDON = true

	local dpawn = api:get_local_pawn(0)
	dpawn.Mesh:call("SetVisibility", true)
	dpawn.Mesh:call("SetRenderInMainPass", false)

	dpawn.DID:call("SetVisibility", true)
	dpawn.DID:call("SetRenderInMainPass", true)

	dpawn.DIDScreen:call("SetVisibility", true)
	dpawn.DIDScreen:call("SetRenderInMainPass", true)
end

local function DeDID()
	local ftpawn = api:get_local_pawn(0)
	if ftpawn ~= nil then
		local IsSC = ftpawn:get_property("IsInCutscene")

		if IsSC == true or string.find(ftpawn:get_full_name(), "Kuronosu")
		then
			--print("Waiting for Cut")
		else
			DIDON = false

			local dpawn = api:get_local_pawn(0)
			dpawn.Mesh:call("SetVisibility", false)
			dpawn.Mesh:call("SetRenderInMainPass", false)

			dpawn.DID:call("SetVisibility", false)
			dpawn.DID:call("SetRenderInMainPass", false)

			dpawn.DIDScreen:call("SetVisibility", false)
			dpawn.DIDScreen:call("SetRenderInMainPass", false)
		end
	end
end

local function DidOffsets()
	params.vr.set_mod_value("UI_Distance", "0.300")
	params.vr.set_mod_value("UI_Size", "0.300")
	params.vr.set_mod_value("UI_X_Offset", "-0.05")
	params.vr.set_mod_value("UI_Y_Offset", "0.00")
end

local function DidCloseOffsets()
	params.vr.set_mod_value("UI_Distance", "4.500")
	params.vr.set_mod_value("UI_Size", "3.60")
	params.vr.set_mod_value("UI_X_Offset", "0.00")
	params.vr.set_mod_value("UI_Y_Offset", "0.00")
end

local function InteractionOffsets()
	local ftpawn = api:get_local_pawn(0)
	if ftpawn ~= nil then
		CurInt = ftpawn:get_property("InteractingObject")
		if Playing == false and CurInt ~= nil then
			if string.find(CurInt:get_full_name(), "HexacoreTerminal") or string.find(CurInt:get_full_name(), "HIVEHospital") then
				--print("Hex Interact")
				HEXActive = true
				params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
				HideAllWeap()
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
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
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				params.vr.set_mod_value("UI_Distance", "0.680")
				params.vr.set_mod_value("UI_Size", "1.255")
				params.vr.set_mod_value("UI_X_Offset", "-0.20")
				params.vr.set_mod_value("UI_Y_Offset", "0.00")
			elseif string.find(CurInt:get_full_name(), "LockDoor") or string.find(CurInt:get_full_name(), "DoorLocker") then
				--print("Lock Interact")
				LockActive = true
				HideAllWeap()
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
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
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				params.vr.set_mod_value("UI_Distance", "0.500")
				params.vr.set_mod_value("UI_Size", "1.070")
				params.vr.set_mod_value("UI_X_Offset", "-0.300")
				params.vr.set_mod_value("VR_CameraForwardOffset", "-22.270")
				params.vr.set_mod_value("VR_CameraUpOffset", "15.00")
			elseif string.find(CurInt:get_full_name(), "PCServerMan") then
				--print("PC Interact")
				PcActive = true
				HideAllWeap()
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
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
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				params.vr.set_mod_value("UI_Distance", "1.355")
				params.vr.set_mod_value("UI_Size", "1.825")
				params.vr.set_mod_value("UI_X_Offset", "-0.40")
				params.vr.set_mod_value("VR_CameraUpOffset", "20.00")
			elseif string.find(CurInt:get_full_name(), "MorseCodePC") then
				--print("MorseCodePC Interact")
				MpcBegin = true
				HideAllWeap()
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				params.vr.set_mod_value("UI_Distance", "0.785")
				params.vr.set_mod_value("UI_Size", "0.685")
				params.vr.set_mod_value("VR_CameraForwardOffset", "-12.75")
				params.vr.set_mod_value("VR_CameraUpOffset", "21.20")
			elseif string.find(CurInt:get_full_name(), "ScreenGen") then
				--print("Generator PC Interact")
				SGActive = true
				HideAllWeap()
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
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
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
				params.vr.set_aim_method(0)
				params.vr.set_mod_value("UI_Distance", "0.500")
				params.vr.set_mod_value("UI_Size", "0.780")
				params.vr.set_mod_value("UI_X_Offset", "-0.300")
			elseif string.find(CurInt:get_full_name(), "SewerPC") then
				--print("SewerPC Interact")
				SpcBegin = true
				HideAllWeap()
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				params.vr.set_mod_value("UI_Distance", "0.50")
				params.vr.set_mod_value("UI_Size", "0.80")
				params.vr.set_mod_value("UI_X_Offset", "-0.40")
				params.vr.set_mod_value("VR_CameraForwardOffset", "-7.50")
				params.vr.set_mod_value("VR_CameraUpOffset", "22.71")
			elseif string.find(CurInt:get_full_name(), "PompeDrenaggio") then
				--print("WirePuzzle Interact")
				WPBegin = true
				HideAllWeap()
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				params.vr.set_mod_value("UI_Distance", "0.690")
				params.vr.set_mod_value("UI_Size", "1.070")
				params.vr.set_mod_value("UI_X_Offset", "-0.400")
				params.vr.set_mod_value("UI_Y_Offset", "0.200")
				params.vr.set_mod_value("VR_CameraForwardOffset", "-15.00")
			elseif string.find(CurInt:get_full_name(), "LievBossFight") then
				--print("Liev Boss")
				MGActive = true
				HideAllWeap()
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
			elseif string.find(CurInt:get_full_name(), "DirectorPuzzle") then
				--print("Director Puzzle Interact")
				MGActive = true
				HideAllWeap()
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
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
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
				params.vr.set_aim_method(0)
				params.vr.set_mod_value("UI_Distance", "1.165")
				params.vr.set_mod_value("UI_Size", "1.730")
				params.vr.set_mod_value("UI_X_Offset", "-0.50")
			elseif string.find(CurInt:get_full_name(), "BP_HexacoreArchive_C") then
				--print("Hex Archive Puzzle Interact")
				MGActive = true
				HideAllWeap()
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
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
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
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
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
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
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
				params.vr.set_aim_method(0)
				params.vr.set_mod_value("UI_Distance", "0.690")
				params.vr.set_mod_value("UI_Size", "0.975")
			elseif string.find(CurInt:get_full_name(), "BP_MorseAlpahbetPC_C") then
				--print("Morse Alphabet Interact")
				MGActive = true
				HideAllWeap()
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
				params.vr.set_aim_method(0)
				params.vr.set_mod_value("UI_Distance", "0.595")
				params.vr.set_mod_value("UI_Size", "0.975")
				params.vr.set_mod_value("UI_X_Offset", "-0.40")
			elseif string.find(CurInt:get_full_name(), "BP_PCSarah_C") then
				--print("Morse Alphabet Interact")
				MGActive = true
				HideAllWeap()
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
				params.vr.set_aim_method(0)
				params.vr.set_mod_value("UI_Distance", "0.500")
				params.vr.set_mod_value("UI_Size", "0.975")
				params.vr.set_mod_value("UI_X_Offset", "-0.500")
				params.vr.set_mod_value("VR_CameraForwardOffset", "-11.55")
				params.vr.set_mod_value("VR_CameraUpOffset", "24.95")
			elseif string.find(CurInt:get_full_name(), "BP_EnvInteract_C") then
				--print("Morse Alphabet Interact")
				Reading = true
				params.vr.set_mod_value("UI_Distance", "0.886")
				params.vr.set_mod_value("UI_Size", "0.886")
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
			end
		end
	end
end

local function PauseOffsets()
	if FunBegin == true or LockActive == true or PcActive == true or FountainBegin == true or SGActive == true or NitroBegin == true or SakBegin == true or MpcBegin == true or SpcBegin == true or WPBegin == true or MGActive == true then
		params.vr.set_mod_value("UI_Distance", "4.500")
		params.vr.set_mod_value("UI_Size", "3.60")
		params.vr.set_mod_value("UI_X_Offset", "0.00")
		params.vr.set_mod_value("UI_Y_Offset", "0.00")
	end
end

local function ResumePauseOffsets()
	if FunBegin == true or LockActive == true or PcActive == true or FountainBegin == true or SGActive == true or NitroBegin == true or SakBegin == true or MpcBegin == true or SpcBegin == true or WPBegin == true or MGActive == true then
		InteractionOffsets()
	end
end

local function Init()
	params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
	params.vr.set_mod_value("UI_Distance", "4.500")
	params.vr.set_mod_value("UI_Size", "3.60")
	params.vr.set_mod_value("UI_X_Offset", "0.00")
	params.vr.set_mod_value("UI_Y_Offset", "0.00")
end

local function ResetPlayUI()
	params.vr.set_mod_value("VR_CameraForwardOffset", "0.00")
	params.vr.set_mod_value("VR_CameraUpOffset", "0.00")
	params.vr.set_mod_value("VR_CameraRightOffset", "0.00")
	params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
	params.vr.set_mod_value("UI_Distance", "4.500")
	params.vr.set_mod_value("UI_Size", "3.60")
	params.vr.set_mod_value("UI_X_Offset", "0.00")
	params.vr.set_mod_value("UI_Y_Offset", "0.00")
end

local function AutoAim()
	--AimGesture
	if Playing == true then
		local apawn = api:get_local_pawn(0)
		local apcont = api:get_player_controller(0)
		--local near_int = apawn.InteractingObject
		--local near_fin = apawn.FinisherActorInRange
		if InitLocY == nil then InitLocY = -0.10 end
		--local InitLocY = 0.30
		local right_controller_index = params.vr.get_right_controller_index()
		local right_controller_position = UEVR_Vector3f.new()
		local right_controller_rotation = UEVR_Quaternionf.new()
		params.vr.get_pose(right_controller_index, right_controller_position, right_controller_rotation)

		--print("Position: " .. tostring(right_controller_position.x) .. ", " .. tostring(right_controller_position.y) .. ", " .. tostring(right_controller_position.z))
		--print("Rotation: " .. tostring(right_controller_rotation.x) .. ", " .. tostring(right_controller_rotation.y) .. ", " .. tostring(right_controller_rotation.z) .. ", " .. tostring(right_controller_rotation.w))

		--local pose_x_current = right_controller_position.x
		local pose_y_current = right_controller_position.y
		--local pose_z_current = right_controller_position.z
		if pose_y_current >= InitLocY then
			if weap_aim == false then
				--print("Weapon Aim Active")
				apcont.AimingPressed = true
				weap_aim = true
			end
		elseif pose_y_current <= InitLocY then
			if weap_aim == true then
				--print("Weapon Aim Closed")
				apcont.AimingPressed = false
				weap_aim = false
			end
		end
	end
end

local function WeaponSelect()
	--Weapon Select Gesture
	if Playing == true then
		local InitRot = 0.70
		local InitLocY = 0.60
		local InitLocZ = 0.07
		local InitLocW = -0.60
		local right_controller_index = params.vr.get_right_controller_index()
		local right_controller_position = UEVR_Vector3f.new()
		local right_controller_rotation = UEVR_Quaternionf.new()
		params.vr.get_pose(right_controller_index, right_controller_position, right_controller_rotation)

		--print("Position: " .. tostring(right_controller_position.x) .. ", " .. tostring(right_controller_position.y) .. ", " .. tostring(right_controller_position.z))
		--print("Rotation: " .. tostring(right_controller_rotation.x) .. ", " .. tostring(right_controller_rotation.w))

		local pose_x_current = right_controller_rotation.x
		local pose_y_current = right_controller_position.y
		local pose_z_current = right_controller_position.z
		local pose_w_current = right_controller_rotation.w
		if pose_x_current >= InitRot and pose_w_current <= InitLocW and weap_sel == false then
			--print("Weapon Select Active")
			params.vr.set_aim_method(1)
			--params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			weap_sel = true
		elseif pose_x_current <= InitRot and pose_w_current >= InitLocW and weap_sel == true then
			--print("Weapon Select Closed")
			params.vr.set_aim_method(2)
			params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
			params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
			weap_sel = false
		end
	end
end

local function FTCam()
	local ftpawn = api:get_local_pawn(0)

	CSHideBody()
	ftpawn.bFindCameraComponentWhenViewTarget = false
end

local function GrabStable()
	local HeadClass = api:find_uobject("Class /Script/Engine.CameraAnimInst")
	local HeadInstances = HeadClass:get_objects_matching(false)
	for Index, HeadInstances in pairs(HeadInstances) do
		local isset = tostring(HeadInstances.PlayRate)
		HeadInstances.PlayRate = "0.0"
	end
end

local function SeqPlayer()
	local skeletal_mesh_c = api:find_uobject("Class /Script/LevelSequence.LevelSequencePlayer")
	if skeletal_mesh_c ~= nil then
		local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

		for i, mesh in ipairs(skeletal_meshes) do
			if string.find(mesh:get_fname():to_string(), "AnimationPlayer") then
				if mesh.Status == 1 then
					seq_active = true

					break
				else
					seq_active = false
				end
			end
		end
	end
end

local function DocRead()
	local skeletal_mesh_c = api:find_uobject("BlueprintGeneratedClass /Game/DAYMARE/Code/Core/Inventory/Code/FileObjects/BP_DocumentFile.BP_DocumentFile_C")
	if skeletal_mesh_c ~= nil then
		local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)


		for i, mesh in ipairs(skeletal_meshes) do
			if string.find(mesh:get_fname():to_string(), "Documentfile") then
				if mesh.BillboardVisible == true and IsInInventory == false then
					doc_active = true

					break
				else
					doc_active = false
				end
			end
		end
	end
end

local function NavTut()
	local npawn = api:get_local_pawn(0)
	if string.find(npawn:get_full_name(), "Liev") or string.find(npawn:get_full_name(), "Hospital") then
		local skeletal_mesh_c = api:find_uobject("Class /Script/UMG.UserWidget")
		if skeletal_mesh_c ~= nil then
			local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)


			for i, mesh in ipairs(skeletal_meshes) do
				if string.find(mesh:get_fname():to_string(), "TutorialManagerWidget") and string.find(mesh:get_full_name(), "Transient.GameEngine") then
					if mesh.NavTutorialCombine.CanTakeInput == true and npawn.CombineTutorialDone == false
						or mesh.NavTutorialHacking.CanTakeInput == true and npawn.HackTutorialDone == false
						or mesh.NavTutorialHealing.CanTakeInput == true and npawn.HealTutorialDone == false
						or npawn.Tutorial == true and mesh.NavTutorialHexacoreArea.CanTakeInput == true and mesh.NavTutorialHexacoreArea.Exist == true
						or mesh.NavTutorialInventory.CanTakeInput == true and npawn.InventoryTutorialDone == false
						or mesh.NavTutorialReload.CanTakeInput == true and npawn.ReloadTutorialDone == false
						or mesh.NavTutorialTerminal.CanTakeInput == true and npawn.TerminalTutorialDone == false then
						tut_active = true

						break
					else
						tut_active = false
					end
				end
			end
		end
	end
end

local function Load_SC()
	local npawn = api:get_local_pawn(0)
	local skeletal_mesh_c = api:find_uobject("WidgetBlueprintGeneratedClass /Game/DAYMARE/Code/Core/Menu/BP/BP_LoadingScreenFix.BP_LoadingScreenFix_C")
	if skeletal_mesh_c ~= nil then
		local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)

		for i, mesh in ipairs(skeletal_meshes) do
			if string.find(mesh:get_fname():to_string(), "LoadingScreenFix") and string.find(mesh:get_full_name(), "Transient.GameEngine") then
				--cur_num = tonumber(string.match(mesh:get_full_name(), 'Fix_C_%s*(%S+)'))

				if mesh.Active == true and mesh.IsEnterPressed == true or mesh.Active == true and mesh.IsFaceBottomPressed == true then
					loading_sc = false
				elseif mesh.Active == false and mesh.IsEnterPressed == true or mesh.Active == false and mesh.IsFaceBottomPressed == true then
					loading_sc = false
				elseif mesh.Active == false and mesh.IsEnterPressed == false or mesh.Active == false and mesh.IsFaceBottomPressed == false then
					loading_sc = false
				elseif mesh.Active == true and mesh.IsEnterPressed == false or mesh.Active == true and mesh.IsFaceBottomPressed == false then
					loading_sc = true

					break
				end
			end
		end
	end
end

local function EndLevel()
	local epawn = api:get_local_pawn(0)
	if epawn ~= nil and string.find(epawn:get_full_name(), "Kuronosu") then
		local skeletal_mesh_c = api:find_uobject("BlueprintGeneratedClass /Game/DAYMARE/Code/Core/Puzzles/Kuronosu/BP_KuronosuPCNew.BP_KuronosuPCNew_C")
		if skeletal_mesh_c == nil then
			end_pc_active = false
		else
			local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)


			for i, mesh in ipairs(skeletal_meshes) do
				if string.find(mesh:get_fname():to_string(), "KuronosuPCNew") then
					is_end = mesh.ScreenWidget.Focused

					if is_end == true then
						end_pc_active = true

						break
					else
						end_pc_active = false
					end
				else
					end_pc_active = false
				end
			end
		end
	end
end

local function EndRecap()
	local epawn = api:get_local_pawn(0)
	if string.find(epawn:get_full_name(), "Kuronosu") then
		local skeletal_mesh_c = api:find_uobject("WidgetBlueprintGeneratedClass /Game/DAYMARE/Code/Core/Puzzles/Kuronosu/BP_FinalRecap.BP_FinalRecap_C")
		if skeletal_mesh_c ~= nil then
			local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)
			if skeletal_meshes ~= nil then
				for i, mesh in ipairs(skeletal_meshes) do
					if string.find(mesh:get_fname():to_string(), "FinalRecap") then
						if mesh.Visibility == 4 then
							end_recap_active = true
							--print(tostring(mesh:get_full_name()))

							break
						else
							end_recap_active = false
						end
					end
				end
			end
		end
	end
end

local function DIDWalk()
	local skeletal_mesh_c = api:find_uobject("BlueprintGeneratedClass /Game/DAYMARE/Audio/Blueprint/BP_Dialogue.BP_Dialogue_C")
	if skeletal_mesh_c ~= nil then
		local skeletal_meshes = skeletal_mesh_c:get_objects_matching(false)
		if skeletal_meshes ~= nil then
			for i, mesh in ipairs(skeletal_meshes) do
				if string.find(mesh:get_fname():to_string(), "BP_Dialogue") then
					if mesh.bIsActive == true then
						did_walk_active = true
						--print(tostring(mesh:get_full_name()))

						break
					else
						did_walk_active = false
					end
				end
			end
		end
	end
end

local function WeaponSet()
	WeaponCheck()
	if active_weap and cur_weap ~= nil then
		weap_loc = UEVR_UObjectHook.get_or_add_motion_controller_state(cur_weap)

		if weap_loc then
			weap_loc:set_hand(1)
			weap_loc:set_permanent(true)
			weap_loc = UEVR_UObjectHook.remove_motion_controller_state(cur_weap)
			weap_loc = UEVR_UObjectHook.get_or_add_motion_controller_state(cur_weap)
			if string.find(cur_weap:get_full_name(), "MP5") then
				if string.find(GetPawn, "Liev") then
					Glock:call("SetRenderInMainPass", false)
					Glock:call("SetVisibility", false)
					Glock_m:call("SetRenderInMainPass", false)
					Glock_m:call("SetVisibility", false)
					Mp5:call("SetRenderInMainPass", true)
					Mp5:call("SetVisibility", true)
					Mp5_m:call("SetRenderInMainPass", true)
					Mp5_m:call("SetVisibility", true)
					Mp5_r:call("SetRenderInMainPass", true)
					Mp5_r:call("SetVisibility", true)
				end
				weap_loc:set_rotation_offset(Vector3f.new(-0.00, 1.580, -0.000))
				weap_loc:set_location_offset(Vector3f.new(0.000, -3.000, 0.000))
			elseif string.find(cur_weap:get_full_name(), "Glock") then
				if string.find(GetPawn, "Liev") then
					Mp5:call("SetRenderInMainPass", false)
					Mp5:call("SetVisibility", false)
					Mp5_m:call("SetRenderInMainPass", false)
					Mp5_m:call("SetVisibility", false)
					Glock:call("SetRenderInMainPass", true)
					Glock:call("SetVisibility", true)
					Glock_m:call("SetRenderInMainPass", true)
					Glock_m:call("SetVisibility", true)
					Glock_r:call("SetRenderInMainPass", true)
					Glock_r:call("SetVisibility", true)
				end
				if string.find(GetPawn, "Samuel") then
					Shotgun:call("SetRenderInMainPass", false)
					Shotgun:call("SetVisibility", false)
					Shotgun_m:call("SetRenderInMainPass", false)
					Shotgun_m:call("SetVisibility", false)
					Revolver:call("SetRenderInMainPass", false)
					Revolver:call("SetVisibility", false)
					Revolver_m:call("SetRenderInMainPass", false)
					Revolver_m:call("SetVisibility", false)
					Glock:call("SetRenderInMainPass", true)
					Glock:call("SetVisibility", true)
					Glock_m:call("SetRenderInMainPass", true)
					Glock_m:call("SetVisibility", true)
					Glock_r:call("SetRenderInMainPass", true)
					Glock_r:call("SetVisibility", true)
				end
				weap_loc:set_rotation_offset(Vector3f.new(-0.00, 1.580, -0.000))
				weap_loc:set_location_offset(Vector3f.new(-2.000, -3.000, 0.000))
			elseif string.find(cur_weap:get_full_name(), "Beretta") then
				if string.find(GetPawn, "Raven") then
					Shotgun:call("SetRenderInMainPass", false)
					Shotgun:call("SetVisibility", false)
					Shotgun_m:call("SetRenderInMainPass", false)
					Shotgun_m:call("SetVisibility", false)
					DesertEagle:call("SetRenderInMainPass", false)
					DesertEagle:call("SetVisibility", false)
					DesertEagle_m:call("SetRenderInMainPass", false)
					DesertEagle_m:call("SetVisibility", false)
					Beretta:call("SetRenderInMainPass", true)
					Beretta:call("SetVisibility", true)
					Beretta_m:call("SetRenderInMainPass", true)
					Beretta_m:call("SetVisibility", true)
					Beretta_r:call("SetRenderInMainPass", true)
					Beretta_r:call("SetVisibility", true)
				end
				weap_loc:set_rotation_offset(Vector3f.new(-0.00, 3.160, -0.000))
				weap_loc:set_location_offset(Vector3f.new(0.000, 0.500, -3.500))
			elseif string.find(cur_weap:get_full_name(), "Shotgun") then
				if string.find(GetPawn, "Raven") then
					Beretta:call("SetRenderInMainPass", false)
					Beretta:call("SetVisibility", false)
					Beretta_m:call("SetRenderInMainPass", false)
					Beretta_m:call("SetVisibility", false)
					DesertEagle:call("SetRenderInMainPass", false)
					DesertEagle:call("SetVisibility", false)
					DesertEagle_m:call("SetRenderInMainPass", false)
					DesertEagle_m:call("SetVisibility", false)
					Shotgun:call("SetRenderInMainPass", true)
					Shotgun:call("SetVisibility", true)
					Shotgun_m:call("SetRenderInMainPass", true)
					Shotgun_m:call("SetVisibility", true)
					Shotgun_r:call("SetRenderInMainPass", true)
					Shotgun_r:call("SetVisibility", true)
				elseif string.find(GetPawn, "Samuel") then
					Glock:call("SetRenderInMainPass", false)
					Glock:call("SetVisibility", false)
					Glock_m:call("SetRenderInMainPass", false)
					Glock_m:call("SetVisibility", false)
					Revolver:call("SetRenderInMainPass", false)
					Revolver:call("SetVisibility", false)
					Revolver_m:call("SetRenderInMainPass", false)
					Revolver_m:call("SetVisibility", false)
					Shotgun:call("SetRenderInMainPass", true)
					Shotgun:call("SetVisibility", true)
					Shotgun_m:call("SetRenderInMainPass", true)
					Shotgun_m:call("SetVisibility", true)
					Shotgun_r:call("SetRenderInMainPass", true)
					Shotgun_r:call("SetVisibility", true)
				end
				weap_loc:set_rotation_offset(Vector3f.new(-0.00, 0.000, -0.000))
				weap_loc:set_location_offset(Vector3f.new(0.000, -3.000, 0.000))
			elseif string.find(cur_weap:get_full_name(), "DesertEagle") then
				if string.find(GetPawn, "Raven") then
					Shotgun:call("SetRenderInMainPass", false)
					Shotgun:call("SetVisibility", false)
					Shotgun_m:call("SetRenderInMainPass", false)
					Shotgun_m:call("SetVisibility", false)
					Beretta:call("SetRenderInMainPass", false)
					Beretta:call("SetVisibility", false)
					Beretta_m:call("SetRenderInMainPass", false)
					Beretta_m:call("SetVisibility", false)
					DesertEagle:call("SetRenderInMainPass", true)
					DesertEagle:call("SetVisibility", true)
					DesertEagle_m:call("SetRenderInMainPass", true)
					DesertEagle_m:call("SetVisibility", true)
					DesertEagle_r:call("SetRenderInMainPass", true)
					DesertEagle_r:call("SetVisibility", true)
				end
				weap_loc:set_rotation_offset(Vector3f.new(-0.00, 1.580, -0.000))
				weap_loc:set_location_offset(Vector3f.new(-2.000, -3.000, 0.000))
			elseif string.find(cur_weap:get_full_name(), "Revolver") then
				if string.find(GetPawn, "Samuel") then
					Shotgun:call("SetRenderInMainPass", false)
					Shotgun:call("SetVisibility", false)
					Shotgun_m:call("SetRenderInMainPass", false)
					Shotgun_m:call("SetVisibility", false)
					Glock:call("SetRenderInMainPass", false)
					Glock:call("SetVisibility", false)
					Glock_m:call("SetRenderInMainPass", false)
					Glock_m:call("SetVisibility", false)
					Revolver:call("SetRenderInMainPass", true)
					Revolver:call("SetVisibility", true)
					Revolver_m:call("SetRenderInMainPass", true)
					Revolver_m:call("SetVisibility", true)
					Revolver_r:call("SetRenderInMainPass", true)
					Revolver_r:call("SetVisibility", true)
				end
				weap_loc:set_rotation_offset(Vector3f.new(-0.00, 1.580, -0.000))
				weap_loc:set_location_offset(Vector3f.new(-2.000, -3.000, 0.000))
			end
		end
	else
		HideAllWeap()
	end
end

params.vr.set_aim_method(0)
reset_height()
ResetPlayUI()

uevr.sdk.callbacks.on_pre_engine_tick(function(engine, delta)
	local pawn = api:get_local_pawn(0)
	local pcont = api:get_player_controller(0)
	if pawn ~= nil then
		GetPawn = pawn:get_full_name()
		is_did = pcont.Inventory
		is_playing = pcont.PauseGUI.InputBlocked
		is_hacking = pcont.IsHacking
		IsInt = pcont:get_property("FullInteracting")
		IsInCut = pcont:get_property("CanSkipCutscene")
		IsBlock = pcont:get_property("BlockInput")
		IsWEquip = pcont:get_property("EquipWeapon")
		GrabActive = pcont.Grabbed
		GrabEscape = pcont.EscapingGrab
		CurInt = "None"
		IsStartCut = pawn:get_property("IsInCutscene")
		IsHexInUse = pawn:get_property("CanTakeInputGameMode")
		is_torch = pawn.TorchActive
		IsHallucinating = pawn:get_property("Hallucinating")
		isvisible = pawn.Mesh.bVisible
		torch_on = pawn.TorchActive
		is_dead = pawn.IsDead
		instant_dead = pcont.InstantDead
		is_status = pcont.RecapStatsWidget.AllActive

		if pcont.PauseGUI.OptionMenu ~= nil then
			options_blocked = pcont.PauseGUI.OptionMenu.InputBlocked
			tutorials_blocked = pcont.PauseGUI.TutorialMenu.InputBlocked
		end

		active_weap = pawn.CurrentWeapon
		SeqPlayer()
		NavTut()
		Load_SC()
		AutoAim()
		WeaponSelect()

		if is_playing == false then
			is_paused = true
			freeze_pause = false
		elseif freeze_pause == false then
			is_paused = false
		end

		if options_blocked == false or tutorials_blocked == false then
			is_paused = true
			freeze_pause = true
		end

		if active_weap ~= nil then
			cur_weap = pawn.CurrentWeapon.SkeletalMesh
		end

		if pawn.godray_cone_02 ~= nil then
			pawn.godray_cone_02:call("SetRenderInMainPass", false)
		end
	end

	EndLevel()

	if pawn == nil or string.find(pawn:get_full_name(), "Kuronosu") or loading_sc == true or is_hacking == true or is_did == true or is_paused == true or seq_active == true or IsStartCut == true or IsHexInUse == false or GrabActive == true or GrabEscape == true or is_dead == true or end_pc_active == true then
		if Mactive == false then
			Mactive = true
			Playing = false
			print("InCut / Menu")
			if Reading == false then
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
			end
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")

			if is_paused ~= true then
				InteractionOffsets()
			else
				PauseOffsets()
			end
			--GrabStable()

			if seq_active == true then
				UEVR_UObjectHook.set_disabled(true)
				params.vr.set_mod_value("VR_CustomZNear", "23.000")
				params.vr.set_mod_value("UI_Distance", "5.000")
				params.vr.set_mod_value("UI_Size", "5.700")
				if IsStartCut == true then
					params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
				else
					params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				end

				if IsHallucinating == true then
					params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
					pawn.bFindCameraComponentWhenViewTarget = false
				end
				CSMP5()
				CSShowBody()
				ShowAllWeap()
			else
				HideAllWeap()
			end

			if is_did == true or is_hacking == true then
				pawn.Mesh:call("SetVisibility", true)
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				params.vr.set_mod_value("VR_DPadShiftingMethod", "3")

				DidOffsets()
				EDID()
			end

			if GrabActive == true or instant_dead == true or is_dead == true then
				HideAllWeap()
				CSShowBody()
			end

			if IsHallucinating == true then
				ShowAllWeap()
			end

			UEVR_UObjectHook.set_disabled(true)
			pinned = false
			params.vr.set_aim_method(0)
		end

		if IsHallucinating == true then
			UEVR_UObjectHook.set_disabled(false)
			WeaponSet()
		end

		if is_did == true then
			DIDWalk()
			if did_walk_active == true then
				params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
			else
				params.vr.set_mod_value("VR_DPadShiftingMethod", "3")
			end
		end

		if pawn == nil or string.find(pawn:get_full_name(), "Kuronosu") then
			if end_pc_active == true then
				EndStarted = true
				params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
				params.vr.set_mod_value("UI_Distance", "0.690")
				params.vr.set_mod_value("UI_Size", "0.500")
				params.vr.set_mod_value("UI_X_Offset", "0.00")
				params.vr.set_mod_value("UI_Y_Offset", "0.100")
				params.vr.set_mod_value("VR_CameraForwardOffset", "-38.00")
				params.vr.set_mod_value("VR_CameraUpOffset", "7.517")
			else
				EndStarted = false
				params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
				params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
				params.vr.set_mod_value("UI_Distance", "4.500")
				params.vr.set_mod_value("UI_Size", "3.60")
				params.vr.set_mod_value("UI_X_Offset", "0.00")
				params.vr.set_mod_value("UI_Y_Offset", "0.00")
				params.vr.set_mod_value("VR_CameraForwardOffset", "0.00")
				params.vr.set_mod_value("VR_CameraUpOffset", "0.00")
				params.vr.set_mod_value("VR_CameraRightOffset", "0.00")
			end
		end

		if pawn == nil then
			end_pc_active = false
			EndStarted = false
			params.vr.set_mod_value("VR_DPadShiftingMethod", "2")
			params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "false")
		end
	else
		if Playing == false and freeze_pause == false then
			pinned = false
			Mactive = false
			Playing = true
			Reading = false
			print("Playing")


			if is_torch == true then
				pawn.TorchLight:call("SetVisibility", true)
			end
			params.vr.set_mod_value("VR_CustomZNear", "1.00")
			ResetPlayUI()
			DeDID()
			DidCloseOffsets()

			params.vr.set_mod_value("VR_DPadShiftingMethod", "0")

			pawn.Mesh:call("SetRenderInMainPass", false)
			pawn.Mesh:call("SetVisibility", false)
			pawn.bFindCameraComponentWhenViewTarget = false
			params.vr.set_mod_value("VR_DecoupledPitchUIAdjust", "true")
			UEVR_UObjectHook.set_disabled(false)
			params.vr.set_aim_method(2)
		end

		if isvisible == true and DIDON == false and CutActive == false and GrabActive == false then
			pawn.Mesh:call("SetVisibility", false)
		end

		if torch_on == true and pawn.TorchLight.bVisible == false then
			pawn.TorchLight:call("SetRenderInMainPass", true)
			pawn.TorchLight:call("SetVisibility", true)
		end

		if tut_active == true or IsInt == true or is_status == true then
			params.vr.set_mod_value("VR_DPadShiftingMethod", "3")
		else
			if weap_sel == false then
				params.vr.set_mod_value("VR_DPadShiftingMethod", "0")
			end
		end


		WeaponCheck()
		if active_weap and cur_weap ~= nil then
			weap_loc = UEVR_UObjectHook.get_or_add_motion_controller_state(cur_weap)

			if weap_loc then
				weap_loc:set_hand(1)
				weap_loc:set_permanent(true)
				weap_loc = UEVR_UObjectHook.remove_motion_controller_state(cur_weap)
				weap_loc = UEVR_UObjectHook.get_or_add_motion_controller_state(cur_weap)
				if string.find(cur_weap:get_full_name(), "MP5") then
					if string.find(GetPawn, "Liev") then
						Glock:call("SetRenderInMainPass", false)
						Glock:call("SetVisibility", false)
						Glock_m:call("SetRenderInMainPass", false)
						Glock_m:call("SetVisibility", false)
						Mp5:call("SetRenderInMainPass", true)
						Mp5:call("SetVisibility", true)
						Mp5_m:call("SetRenderInMainPass", true)
						Mp5_m:call("SetVisibility", true)
						Mp5_r:call("SetRenderInMainPass", true)
						Mp5_r:call("SetVisibility", true)
					end
					weap_loc:set_rotation_offset(Vector3f.new(-0.00, 1.580, -0.000))
					weap_loc:set_location_offset(Vector3f.new(0.000, -3.000, 0.000))
				elseif string.find(cur_weap:get_full_name(), "Glock") then
					if string.find(GetPawn, "Liev") then
						Mp5:call("SetRenderInMainPass", false)
						Mp5:call("SetVisibility", false)
						Mp5_m:call("SetRenderInMainPass", false)
						Mp5_m:call("SetVisibility", false)
						Glock:call("SetRenderInMainPass", true)
						Glock:call("SetVisibility", true)
						Glock_m:call("SetRenderInMainPass", true)
						Glock_m:call("SetVisibility", true)
						Glock_r:call("SetRenderInMainPass", true)
						Glock_r:call("SetVisibility", true)
					end
					if string.find(GetPawn, "Samuel") then
						Shotgun:call("SetRenderInMainPass", false)
						Shotgun:call("SetVisibility", false)
						Shotgun_m:call("SetRenderInMainPass", false)
						Shotgun_m:call("SetVisibility", false)
						Revolver:call("SetRenderInMainPass", false)
						Revolver:call("SetVisibility", false)
						Revolver_m:call("SetRenderInMainPass", false)
						Revolver_m:call("SetVisibility", false)
						Glock:call("SetRenderInMainPass", true)
						Glock:call("SetVisibility", true)
						Glock_m:call("SetRenderInMainPass", true)
						Glock_m:call("SetVisibility", true)
						Glock_r:call("SetRenderInMainPass", true)
						Glock_r:call("SetVisibility", true)
					end
					weap_loc:set_rotation_offset(Vector3f.new(-0.00, 1.580, -0.000))
					weap_loc:set_location_offset(Vector3f.new(-2.000, -3.000, 0.000))
				elseif string.find(cur_weap:get_full_name(), "Beretta") then
					if string.find(GetPawn, "Raven") then
						Shotgun:call("SetRenderInMainPass", false)
						Shotgun:call("SetVisibility", false)
						Shotgun_m:call("SetRenderInMainPass", false)
						Shotgun_m:call("SetVisibility", false)
						DesertEagle:call("SetRenderInMainPass", false)
						DesertEagle:call("SetVisibility", false)
						DesertEagle_m:call("SetRenderInMainPass", false)
						DesertEagle_m:call("SetVisibility", false)
						Beretta:call("SetRenderInMainPass", true)
						Beretta:call("SetVisibility", true)
						Beretta_m:call("SetRenderInMainPass", true)
						Beretta_m:call("SetVisibility", true)
						Beretta_r:call("SetRenderInMainPass", true)
						Beretta_r:call("SetVisibility", true)
					end
					weap_loc:set_rotation_offset(Vector3f.new(-0.00, 3.160, -0.000))
					weap_loc:set_location_offset(Vector3f.new(0.000, 0.500, -3.500))
				elseif string.find(cur_weap:get_full_name(), "Shotgun") then
					if string.find(GetPawn, "Raven") then
						Beretta:call("SetRenderInMainPass", false)
						Beretta:call("SetVisibility", false)
						Beretta_m:call("SetRenderInMainPass", false)
						Beretta_m:call("SetVisibility", false)
						DesertEagle:call("SetRenderInMainPass", false)
						DesertEagle:call("SetVisibility", false)
						DesertEagle_m:call("SetRenderInMainPass", false)
						DesertEagle_m:call("SetVisibility", false)
						Shotgun:call("SetRenderInMainPass", true)
						Shotgun:call("SetVisibility", true)
						Shotgun_m:call("SetRenderInMainPass", true)
						Shotgun_m:call("SetVisibility", true)
						Shotgun_r:call("SetRenderInMainPass", true)
						Shotgun_r:call("SetVisibility", true)
					elseif string.find(GetPawn, "Samuel") then
						Glock:call("SetRenderInMainPass", false)
						Glock:call("SetVisibility", false)
						Glock_m:call("SetRenderInMainPass", false)
						Glock_m:call("SetVisibility", false)
						Revolver:call("SetRenderInMainPass", false)
						Revolver:call("SetVisibility", false)
						Revolver_m:call("SetRenderInMainPass", false)
						Revolver_m:call("SetVisibility", false)
						Shotgun:call("SetRenderInMainPass", true)
						Shotgun:call("SetVisibility", true)
						Shotgun_m:call("SetRenderInMainPass", true)
						Shotgun_m:call("SetVisibility", true)
						Shotgun_r:call("SetRenderInMainPass", true)
						Shotgun_r:call("SetVisibility", true)
					end
					weap_loc:set_rotation_offset(Vector3f.new(-0.00, 0.000, -0.000))
					weap_loc:set_location_offset(Vector3f.new(0.000, -3.000, 0.000))
				elseif string.find(cur_weap:get_full_name(), "DesertEagle") then
					if string.find(GetPawn, "Raven") then
						Shotgun:call("SetRenderInMainPass", false)
						Shotgun:call("SetVisibility", false)
						Shotgun_m:call("SetRenderInMainPass", false)
						Shotgun_m:call("SetVisibility", false)
						Beretta:call("SetRenderInMainPass", false)
						Beretta:call("SetVisibility", false)
						Beretta_m:call("SetRenderInMainPass", false)
						Beretta_m:call("SetVisibility", false)
						DesertEagle:call("SetRenderInMainPass", true)
						DesertEagle:call("SetVisibility", true)
						DesertEagle_m:call("SetRenderInMainPass", true)
						DesertEagle_m:call("SetVisibility", true)
						DesertEagle_r:call("SetRenderInMainPass", true)
						DesertEagle_r:call("SetVisibility", true)
					end
					weap_loc:set_rotation_offset(Vector3f.new(-0.00, 1.580, -0.000))
					weap_loc:set_location_offset(Vector3f.new(-2.000, -3.000, 0.000))
				elseif string.find(cur_weap:get_full_name(), "Revolver") then
					if string.find(GetPawn, "Samuel") then
						Shotgun:call("SetRenderInMainPass", false)
						Shotgun:call("SetVisibility", false)
						Shotgun_m:call("SetRenderInMainPass", false)
						Shotgun_m:call("SetVisibility", false)
						Glock:call("SetRenderInMainPass", false)
						Glock:call("SetVisibility", false)
						Glock_m:call("SetRenderInMainPass", false)
						Glock_m:call("SetVisibility", false)
						Revolver:call("SetRenderInMainPass", true)
						Revolver:call("SetVisibility", true)
						Revolver_m:call("SetRenderInMainPass", true)
						Revolver_m:call("SetVisibility", true)
						Revolver_r:call("SetRenderInMainPass", true)
						Revolver_r:call("SetVisibility", true)
					end
					weap_loc:set_rotation_offset(Vector3f.new(-0.00, 1.580, -0.000))
					weap_loc:set_location_offset(Vector3f.new(-2.000, -3.000, 0.000))
				end
			end
		else
			HideAllWeap()
		end

		if FunBegin == true or LockActive == true or PcActive == true or FountainBegin == true or SGActive == true or NitroBegin == true or SakBegin == true or MpcBegin == true or SpcBegin == true or WPBegin == true or MGActive == true then
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
			MGActive = false
		end
	end
end)

uevr.sdk.callbacks.on_xinput_get_state(function(retval, user_index, state)
	if (state ~= nil) then
		if Playing == false then
			if state.Gamepad.bLeftTrigger ~= 0 and state.Gamepad.bRightTrigger ~= 0 then
				if JustCentered == false then
					JustCentered = true
					reset_height()
					params.vr.recenter_view()
					state.Gamepad.bLeftTrigger = 0
					state.Gamepad.bRightTrigger = 0
				end
			else
				JustCentered = false
			end
		end

		--[[
		if Playing == false and DIDON == true then
			if state.Gamepad.sThumbLX <= -1000 then
				--state.Gamepad.sThumbLX = 0
				state.Gamepad.sThumbRX = -30000
				print("Left")
			end
		end
		
		if Playing == false and DIDON == true then
			if state.Gamepad.sThumbLX >= 1000 then
				--state.Gamepad.sThumbLX = 0
				state.Gamepad.sThumbRX = 30000
				print("Right")
			end
		end
		]]

		if Playing == true then
			if state.Gamepad.sThumbRY >= 30000 then
				if is_jogging == false then
					jogging = true
					state.Gamepad.wButtons = state.Gamepad.wButtons | XINPUT_GAMEPAD_LEFT_SHOULDER
				end
				if is_running == false and jogging == true then
					is_running = true
					state.Gamepad.wButtons = state.Gamepad.wButtons | XINPUT_GAMEPAD_LEFT_THUMB
				end
			else
				jogging = false
				is_running = false
			end
		end

		if Playing == true then
			if state.Gamepad.sThumbRY <= -30000 then
				if is_scanning == false then
					is_scanning = true
					state.Gamepad.wButtons = state.Gamepad.wButtons | XINPUT_GAMEPAD_RIGHT_THUMB
				end
			else
				is_scanning = false
			end
		end
	end
end)
