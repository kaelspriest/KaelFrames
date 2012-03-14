local KaelFrames = LibStub("AceAddon-3.0"):GetAddon("KaelFrames")
local callbacks = KaelFrames.callbacks

local colors = {}
colors.transparent = {0, 0, 0, 0}
KaelFrames.colors = colors

function KaelFrames:GetObject()
	return nil
end

function KaelFrames:ChatCommand(input)
	
end

function KaelFrames:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("KaelFramesDB", KaelFrames.defaults, "Default")
	for name, framestyle in pairs(self.db.profile.framestyles) do
		self.framestyles[name] = {
			style = framestyle,
			active = {},
		}
	end
	self:SpawnAllFrames()
	-- self:RegisterChatCommand(L["kael"], "ChatCommand")
	-- self:RegisterChatCommand(L["kl"], "ChatCommand")
end

function KaelFrames:OnEnable()
	self:Print("Hello World!")
end

function KaelFrames:OnDisable()
end