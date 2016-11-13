levelState = State()

inventory = {}
function addItemToInventory(item)
	table.insert(inventory, item)
end

function removeItemFromInventory(item)
	local idx = -1
	for i, obj in ipairs(inventory) do
		if obj == item then
			idx = i
			break
		end
	end

	if idx ~= -1 then
		table.remove(inventory, idx)
	end
end

infoText = ""

require "Items"

local door = {
	name = "door",
	image = love.graphics.newImage("level0/Door.png"),
	x = 50,
	y = 50,
	width = 64,
	height = 128
}

local head = {
	name = "head",
	image = love.graphics.newImage("level0/Head.png"),
	x = 168,
	y = 115,
	width = 20,
	height = 14
}

local leftArm = {
	name = "left arm",
	image = love.graphics.newImage("level0/LeftArm.png"),
	x = 208,
	y = 113,
	width = 12,
	height = 12
}

local rightArm = {
	name = "right arm",
	image = love.graphics.newImage("level0/RightArm.png"),
	x = 180,
	y = 105,
	width = 12,
	height = 12
}

local rightFoot = {
	name = "right foot",
	image = love.graphics.newImage("level0/RightFoot.png"),
	x = 180,
	y = 105,
	width = 12,
	height = 12
}

local chains = {
	name = "chains",
	image = love.graphics.newImage("level0/Chains.png"),
	x = 171,
	y = 50,
	width = 0,
	height = 0
}

local girl = {
	body = {
		name = "Girl's body",
		image = love.graphics.newImage("level0/Body.png"),
		x = 183,
		y = 75,
		width = 17,
		height = 25
	},
	head = {
		name = "Girl's head",
		image = love.graphics.newImage("level0/HeadOn.png"),
		x = 182,
		y = 56,
		width = 18,
		height = 19,
		use = function(self, item)
			if item == saw and not self.off then 
				self.off = true
				self.name = "Girl's headless neck"
				self.image = love.graphics.newImage("level0/HeadOff.png")
				infoText = "You cut Girl's head!"

				levelState:addObject(head)
				return true
			end

			return false
		end
	},
	leftArm = {
		name = "Girl's left arm",
		image = love.graphics.newImage("level0/LeftArmOn.png"),
		x = 199,
		y = 70,
		width = 11,
		height = 13,
		use = function(self, item)
			if item == saw and not self.off then 
				self.off = true
				self.name = "Girl's LArm"
				self.image = love.graphics.newImage("level0/LeftArmOff.png")
				infoText = "You cut Girl's left arm!"

				levelState:addObject(leftArm)
				return true
			end

			return false
		end
	},

	rightArm = {
		name = "Girl's right arm",
		image = love.graphics.newImage("level0/RightArmOn.png"),
		x = 171,
		y = 68,
		width = 14,
		height = 15,
		use = function(self, item)
			if item == saw and not self.off then 
				self.off = true
				self.name = "Girl's RArm"
				self.image = love.graphics.newImage("level0/RightArmOff.png")
				infoText = "You cut Girl's right arm!"

				levelState:addObject(rightArm)
				return true
			end

			return false
		end
	},
	leftFoot = {
		name = "Girl's left foot",
		image = love.graphics.newImage("level0/LeftFootOn.png"),
		x = 188,
		y = 100,
		width = 13,
		height = 13,
		use = function(self, item)
			if item == saw and not self.off then 
				self.off = true
				self.name = "Girl's LFoot"
				self.image = love.graphics.newImage("level0/LeftFootOff.png")
				infoText = "You cut Girl's left foot!"

				addItemToInventory(leftFoot)
				return true
			end

			return false
		end
	},

	rightFoot = {
		name = "Girl's right foot",
		image = love.graphics.newImage("level0/RightFootOn.png"),
		x = 183,
		y = 100,
		width = 8,
		height = 9,
		use = function(self, item)
			if item == saw and not self.off then 
				self.off = true
				self.name = "Girl's RFoot"
				self.image = love.graphics.newImage("level0/RightFootOff.png")
				infoText = "You cut Girl's right foot!"

				levelState:addObject(rightFoot)
				return true
			end

			return false
		end
	},
}

function door:use(item)
	if item == leftFoot then
		infoText = "SUCCESS!!!"
		return true
	end

	return false
end

function drawInventory()
	local x = 0
	local y = 148
	for i, item in ipairs(inventory) do
		love.graphics.draw(item.image, x, y)
		x =  x + 32

		if x >= 320 then
			x = 0
			y = y + 16
		end
	end
end

-- add an object to the scene
function levelState:addObject(item)
	table.insert(self.objects, item)
end

-- remove an object from the scene
function levelState:removeObject(item)
	local idx = -1
	for i, obj in ipairs(self.objects) do
		if obj == item then
			idx = i
			break
		end
	end

	if idx ~= -1 then
		table.remove(self.objects, idx)
	end
end

function levelState:load()
	self.backgroundImage = love.graphics.newImage("level0/Background.png")

	selectedItem = nil

	self.objects = {}
	table.insert(self.objects, door)

	infoText = "New room, new nightmare..."

	-- add the girl
	self:addObject(girl.body)
	self:addObject(girl.head)
	self:addObject(girl.leftArm)
	self:addObject(girl.rightArm)
	self:addObject(girl.leftFoot)
	self:addObject(girl.rightFoot)

	self:addObject(chains)

	-- add the saw
	saw.x = 111
	saw.y = 115
	self:addObject(saw)
end

function levelState:draw()
	State.draw(self)

	for i, obj in ipairs(self.objects) do
		love.graphics.draw(obj.image, obj.x, obj.y)
	end

	drawInventory()
	printOutlined(infoText, 8, 8, {255, 0, 0, 255})

	love.graphics.setColor(255, 255, 255, 255)

	if selectedItem then
		love.graphics.draw(selectedItem.image, selectedItem.x - 16, selectedItem.y - 8)
	end
end

function levelState:mousemoved(x, y, dx, dy)
	if selectedItem then
		selectedItem.x = x
		selectedItem.y = y
	end
end

function levelState:mousepressed(x, y, button)
	if button == 1 or button == "l" then
		if y > 144 then
			local itemIdx = math.floor(x / 32) + math.floor((y - 144) / 16) + 1
			print(itemIdx)

			newItem = inventory[itemIdx]

			-- if we click on an item 
			if newItem then
				-- if we don't have any item selected, select it
				if not selectedItem then
					selectedItem = newItem

					if selectedItem then
						selectedItem.x = x
						selectedItem.y = y
					end
				else
					-- else, combine item
					local res = newItem:use(selectedItem)

					if not res then
						infoText = selectedItem.name .. " doesn't seems to work with " .. newItem.name .."."						
					end
				end
			end
		else
			for i, obj in ipairs(self.objects) do
				if obj.use and testPointInQuad(x, y, obj.x, obj.y, obj.width, obj.height) then
					local res = obj:use(selectedItem)

					if not res then
						if selectedItem then
							infoText = selectedItem.name .. " doesn't seems to work with " .. obj.name .."."
						else
							infoText = "You can't do anything with " .. obj.name .. " alone."
						end
					end
				end
			end
		end
	end

	if button == 2 or button == "r" then
		selectedItem = nil
	end
end

