local KaelFrames = LibStub("AceAddon-3.0"):GetAddon("KaelFrames")
local Frames = {}
Frames.PassLibraryMethods = KaelFrames.PassLibraryMethods

function KaelFrames:SpawnAllFrames()
	local units = self.db.profile.units
	for unit, settings in pairs(units) do
		if settings.enabled then
			local style = settings.framestyle
			self:Spawn(unit, style)
		end
	end
	local headers = self.db.profile.headers
	for header, settings in pairs(headers) do
		if settings.enabled then
			local style = settings.framestyle
			self:SpawnHeader(header, style)
		end
	end
	for _, frame in pairs(self.frames) do
		frame:Finalize()
	end
end

function KaelFrames:Spawn(unit, style)
	if not self.frames[unit] then
		local frame = self:Create(unit)
		self.frames[unit] = frame
	end
	local frame = self.frames[unit]
	
	frame.unit = unit
	frame.unitsettings = self.db.profile.units[unit]
	frame:SetStyle(style)
	frame:Configure()
	frame:SpawnElements()
	return frame
end

function KaelFrames:SpawnHeader(header, style)

end

function KaelFrames:Create(unit)
	local frame = CreateFrame("Button", "KaelFrames_"..unit, UIParent, "SecureUnitButtonTemplate")
	frame.backdrop = CreateFrame("Frame", nil, frame)
	SecureUnitButton_OnLoad(frame, unit)
	RegisterUnitWatch(frame)
	KaelFrames:PassLibraryMethods(frame)
	Frames:PassLibraryMethods(frame)
	frame:SetClampedToScreen(true)
	frame.elements = {}
	return frame
end

function KaelFrames:CreateHeader(header)
	local frame = CreateFrame("Frame", "KaelFrames_"..header, UIParent, "SecureGroupHeaderTemplate")
	frame:SetClampedToScreen(true)
	return frame
end

local lib = {}

function lib:SpawnElements()
	local style = self.style
	
	for modulename, module in pairs(KaelFrames.modules) do
		if style.modules[modulename].enabled then
			local element = module:Spawn(self, style.modules[modulename])
			self.elements[modulename] = element
			KaelFrames:PassLibraryMethods(element)
		end
	end
	for _, element in pairs(self.elements) do
		element:Finalize()
	end
end

local function StartDrag(self)
	self:SetMovable(true)
	self:StartMoving()
	self:SetUserPlaced(false)
end

local function StopDrag(self)
	self:StopMovingOrSizing()
	self:SetMovable(false)
	local anchorfrom, _, anchorto, horizoffset, vertoffset = self:GetPoint()
	self.position.anchorfrom = anchorfrom
	self.position.anchorto = anchorto
	self.position.offsets.horizontal = horizoffset
	self.position.offsets.vertical = vertoffset
	self:SetPosition()
end


function lib:Unlock()
	self:EnableMouse(true)
	self:SetScript("OnDragStart", StartDrag)
	self:SetScript("OnDragStop", StopDrag)
	self:RegisterForDrag("LeftButton")
end

function lib:Lock()
	self:RegisterForDrag(nil)
	self:SetScript("OnDragStart", nil)
	self:SetScript("OnDragStop", nil)
	self:EnableMouse(self.unitsettings.enablemouse)
end

function lib:PreConfigure()
	local unitsettings = self.unitsettings
	self:SetFrameStrata(unitsettings.strata)
	self:SetFrameLevel(10 * unitsettings.level)
	self.backdrop:SetFrameLevel(10 * unitsettings.level - 9)
	self:EnableMouse(unitsettings.enablemouse)
end

function lib:PostConfigure()

end

function lib:PreFinalize()
	self:Unlock()
end

function lib:PostFinalize()

end

Frames.lib = lib