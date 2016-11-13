saw = {
	name = "Saw",
	image = love.graphics.newImage("saw.png")
}

function saw:use(item)
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


addItemToInventory(saw)
addItemToInventory(jerrycan)
