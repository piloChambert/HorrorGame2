saw = {
	name = "Saw",
	image = love.graphics.newImage("saw.png"),
	width = 32,
	height = 16
}

function saw:use(item)
	if item == nil then
		-- pickup
		addItemToInventory(self)
		levelState:removeObject(self)
		return true
	end

	return false
end

jerrycan = {
	name = "JerryCan",
	image = love.graphics.newImage("jerrycan.png")
}
function jerrycan:use(item)
	if item == saw then
		removeItemFromInventory(jerrycan)
		removeItemFromInventory(saw)
		selectedItem = nil

		infoText = "It destroyed the JerryCan!!!"
		return true
	end
	return false
end


--addItemToInventory(saw)
--addItemToInventory(jerrycan)

leftFoot = {
	name = "left foot",
	image = love.graphics.newImage("level0/LeftFoot.png"),
}

function leftFoot:use(item)
	return false
end