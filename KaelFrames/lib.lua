local KaelFrames = LibStub("AceAddon-3.0"):GetAddon("KaelFrames")
local LSM = KaelFrames.LSM
local callbacks = KaelFrames.callbacks
local framestyles = KaelFrames.framestyles
local lib = {}

function lib:error(n, ...)
	self:Print("|cffff0000Error|r ".."|cffffff00"..n.."|r: "..string.format(...))
end

function lib:SetStyle(stylename)
	self.style = framestyles[stylename].style
	framestyles[stylename].active[self.unit] = self
	self:Configure()
end

function lib:FillSetPosition()
	local style = self.style
	local position = self.position
	local anchorframe = KaelFrames:GetObject(position.anchorframe) or self.parent
	
	self:ClearAllPoints()
	
	if style.fill then
		local leftoffset, rightoffset = position.offsets.left, position.offsets.right
		local topoffset, bottomoffset = position.offsets.top, position.offsets.bottom
		self:SetPoint("TOPLEFT", anchorframe, "TOPLEFT", leftoffset, topoffset)
		self:SetPoint("BOTTOMRIGHT", anchorframe, "BOTTOMRIGHT", rightoffset, bottomoffset)
		return
	end
end

function lib:FitSetPosition()
	local style = self.unitsettings or self.style
	local position = self.position
	local anchorframe = KaelFrames:GetObject(position.anchorframe) or self:GetParent()
	
	self:ClearAllPoints()
	
	local anchorfrom, anchorto = position.anchorfrom, position.anchorto
	local vertoffset, horizoffset = position.offsets.vertical, position.offsets.horizontal
	
	if style.fitwidth then
		local leftoffset, rightoffset = position.offsets.left, position.offsets.right
		local leftanchor, rightanchor = KaelFrames:GetObject(position.anchors.left), KaelFrames:GetObject(position.anchors.right)
		if leftanchor then
			leftpoint = "RIGHT"
		else
			leftanchor = anchorframe
			leftpoint = "LEFT"
		end
		
		if rightanchor then
			rightpoint = "LEFT"
		else
			rightanchor = anchorframe
			rightpoint = "RIGHT"
		end
		self:SetPoint("LEFT", leftanchor, leftpoint, leftoffset)
		self:SetPoint("RIGHT", rightanchor, rightpoint, rightoffset)
		
		if not style.fitheight then
			self:SetPoint(anchorfrom, anchorframe, anchorto, 0, vertoffset)
		end
	end
	
	if style.fitheight then
		local topoffset, bottomoffset = position.offsets.top, position.offsets.bottom
		local topanchor, bottomanchor = KaelFrames:GetObject(position.anchors.top), KaelFrames:GetObject(position.anchors.bottom)
		if topanchor then
			toppoint = "BOTTOM"
		else
			topanchor = anchorframe
			toppoint = "TOP"
		end
		
		if bottomanchor then
			bottompoint = "TOP"
		else
			bottomanchor = anchorframe
			bottompoint = "BOTTOM"
		end
		self:SetPoint("TOP", topanchor, toppoint, nil, topoffset)
		self:SetPoint("BOTTOM", bottomanchor, bottompoint, nil, bottomoffset)
		
		if not style.fitwidth then
			self:SetPoint(anchorfrom, anchorframe, anchorto, horizoffset, 0)
		end
	end
	
end

function lib:SimpleSetPosition(from, frame, to, ofsx, ofsy)
	local position = self.position
	local anchorfrom = from or position.anchorfrom
	local anchorframe = KaelFrames:GetObject(frame) or KaelFrames:GetObject(position.anchorframe)
	anchorframe = anchorframe or self:GetParent()
	local anchorto = to or position.anchorto
	local horizoffset = ofsx or position.offsets.horizontal
	local vertoffset = ofsy or position.offsets.vertical
	
	self:ClearAllPoints()
	self:SetPoint(anchorfrom, anchorframe, anchorto, horizoffset, vertoffset)
end

function lib:SetPositionStyle()
	local style = self.unitsettings or self.style
	self.position = style.position
	
	if style.fill then self.SetPosition = self.FillSetPosition
	elseif (style.fitwidth or style.fitheight) then self.SetPosition = self.FitSetPosition
	else self.SetPosition = self.SimpleSetPosition
	end
	
end

function lib:RelativeSetElementSize()
	local style = self.style
	
	if self.bg then
		self.bg:SetAllPoints(self)
	end
	
	if style.fill then return end
	
	local parent = self:GetParent()
	local width = style.widthmult * parent:GetWidth()
	local height = style.heightmult * parent:GetHeight()
	if not style.fitwidth then self:SetWidth(width) end
	if not style.fitheight then self:SetHeight(height) end
end

function lib:AbsoluteSetElementSize()
	local style = self.style
	
	if self.bg then
		self.bg:SetAllPoints(self)
	end	
	
	self:SetWidth(style.width)
	self:SetHeight(style.height)
end

function lib:SetSizeStyle()
	local style = self.style
	
	if style.relativesize then self.SetElementSize = self.RelativeSetElementSize
	else self.SetElementSize = self.AbsoluteSetElementSize
	end
end

function lib:SetElementBackdrop()
	local backdropstyle = self.style.backdrop.style
	
	local backdroptable = self.style.backdrop.table
	self.backdrop:SetBackdrop(backdroptable)
	
	local inset = backdropstyle.bginset - backdropstyle.borderinset
	self.backdrop:SetPoint("TOPLEFT", -inset, inset)
	self.backdrop:SetPoint("BOTTOMRIGHT", inset, -inset)
	
	self:ColorBackdrop()
	self:ColorBorder()
end

function lib:ColorBackdrop(color)
	local backdropstyle = self.style.backdrop.style
	local backdropcolor
	
	if backdropstyle.enablebackdrop then
		backdropcolor = color or backdropstyle.bgcolor
	else
		backdropcolor = color or KaelFrames.colors.transparent
	end
	
	self.backdrop:SetBackdropColor(unpack(backdropcolor))
end

function lib:ColorBorder(color)
	local backdropstyle = self.style.backdrop.style
	local bordercolor
	
	if backdropstyle.enableborder then
		bordercolor = color or backdropstyle.bordercolor
	else
		bordercolor = color or KaelFrames.colors.transparent
	end
	
	self.backdrop:SetBackdropBorderColor(unpack(bordercolor))
end

function lib:SetElementColor(color, alpha)
	local style = self.style
	local texturecolor = color or style.color
	texturecolor = texturecolor or KaelFrames.colors.white
	
	self:SetVertexColor(unpack(texturecolor))
end

function lib:SetElementAlpha(a)
	local style = self.style
	local alpha = a or style.alpha
	alpha = alpha or 1
	
	self:SetAlpha(alpha)
	if self.bg then
		self.bg:SetAlpha(alpha)
	end
end

function lib:Configure()
	local style = self.style
	if self.PreConfigure then self:PreConfigure() end
	self:SetSizeStyle()
	self:SetElementSize()
	self:SetElementBackdrop()
	self:SetElementAlpha()
	self:SetPositionStyle()
	if self.PostConfigure then self:PostConfigure() end
end

function lib:Finalize()
	if self.PreFinalize then self:PreFinalize() end
	self:SetPosition()
	if self.PostFinalize then self:PostFinalize() end
end

KaelFrames.lib = lib