local KaelFrames = LibStub("AceAddon-3.0"):NewAddon("KaelFrames", "AceConsole-3.0")
local LSM = LibStub("LibSharedMedia-3.0")
local callbacks = KaelFrames.callbacks or LibStub("CallbackHandler-1.0"):New(KaelFrames)
local frames = {}
local framestyles = {}

function KaelFrames:PassLibraryMethods(element)
	for k, v in pairs(self.lib) do
		element[k] = v
	end
end

KaelFrames.LSM = LSM
KaelFrames.frames = frames
KaelFrames.framestyles = framestyles
KaelFrames.callbacks = callbacks