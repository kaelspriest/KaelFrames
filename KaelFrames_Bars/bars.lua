local KaelFrames = LibStub("AceAddon-3.0"):GetAddon("KaelFrames")
local Bars = KaelFrames:NewModule("Bars")
local LSM = KaelFrames.LSM
local callbacks = KaelFrames.callbacks

Bars.PassLibraryMethods = KaelFrames.PassLibraryMethods

function Bars:Create()
	local bar = CreateFrame("StatusBar", nil, self)
	bar.bg = CreateFrame("StatusBar", nil, self)
	bar.backdrop = CreateFrame("Frame", nil, bar)
	KaelFrames:PassLibraryMethods(bar)
	Bars:PassLibraryMethods(bar)
	return bar
end

local lib = {}

function lib:SetElementTexture()

end

function lib:SetElementRotation()
	local style = self.style
	
	if style.vertical then
		self:SetOrientation("VERTICAL")
		self.bg:SetOrientation("VERTICAL")
		self:SetRotatesTexture(true)
		self.bg:SetRotatesTexture(true)
	else
		self:SetOrientation("HORIZONTAL")
		self.bg:SetOrientation("HORIZONTAL")
		self:SetRotatesTexture(false)
		self.bg:SetRotatesTexture(false)
	end
end

function lib:SetElementColor(color, bgcolor)
	local style = self.style
	local barcolor = color or style.color
	local barbgcolor = bgcolor or style.bg.color
	local colormult, alphamult = style.bg.colormult, style.bg.alphamult
	
	local r, g, b, a = unpack(barcolor)
	local rb, gb, bb, ab
	
	if style.custombgcolor or bgcolor then
		rb, gb, bb, ab = unpack(barbgcolor)
	else
		rb, gb, bb, ab = r, g, b, a	
	end
	
	rb, gb, bb, ab = r * colormult, g * colormult, b * colormult, a * alphamult
	
	self:SetStatusBarColor(r, g, b, a)
	self.bg:SetStatusBarColor(rb, gb, bb, ab)
end


Bars.lib = lib