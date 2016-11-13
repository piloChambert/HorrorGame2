levelState = State()

require "Items"

local door = {
	name = "door",
	image = love.graphics.newImage("door.png"),
	x = 100,
	y = 0,
	width = 64,
	height = 128
}

function door:use(item)
	if not item  then
		if self.open then
			self.image = love.graphics.newImage("door.png")
			self.open = false
		else
			self.image = love.graphics.newImage("door_open.png")
			self.open = true
		end

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

function levelState:load()
	self.backgroundImage = love.graphics.newImage("Background_lvl0.png")

	for i = 0, 20 do	
		table.insert(inventory, saw)
	end

	self.text = "A saw"
	self.selectedItem = nil

	self.objects = {}
	table.insert(self.objects, door)

	infoText = "New room, new nightmare..."
end

function levelState:draw()
	State.draw(self)

	for i, obj in ipairs(self.objects) do
		love.graphics.draw(obj.image, obj.x, obj.y)
	end

	drawInventory()
	love.graphics.print(infoText, 0, 140)

	if self.selectedItem then
		love.graphics.draw(self.selectedItem.image, self.selectedItem.x, self.selectedItem.y)
	end
end

function levelState:mousemoved(x, y, dx, dy)
	if self.selectedItem then
		self.selectedItem.x = x
		self.selectedItem.y = y
	end
end

function levelState:mousepressed(x, y, button)
	if button == 1 or button == "l" then
		if y > 144 then
			self.selectedItem = saw
			self.selectedItem.x = x
			self.selectedItem.y = y
		else
			for i, obj in ipairs(self.objects) do
				if testPointInQuad(x, y, obj.x, obj.y, obj.width, obj.height) then
					local res = obj:use(self.selectedItem)

					if not res then
						if self.selectedItem then
							infoText = self.selectedItem.name .. " doesn't seems to work with " .. obj.name .."."
						else
							infoText = "You can't do anything with " .. obj.name .. "alone."
						end
					end
				end
			end
		end
	end

	if button == 2 or button == "r" then
		self.selectedItem = nil
	end
end

