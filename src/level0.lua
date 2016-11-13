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

	selectedItem = nil

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
				if testPointInQuad(x, y, obj.x, obj.y, obj.width, obj.height) then
					local res = obj:use(selectedItem)

					if not res then
						if selectedItem then
							infoText = selectedItem.name .. " doesn't seems to work with " .. obj.name .."."
						else
							infoText = "You can't do anything with " .. obj.name .. "alone."
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

