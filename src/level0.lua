level0State = State()

saw = {
	image = love.graphics.newImage("saw.png")
}

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

function level0State:load()
	self.backgroundImage = love.graphics.newImage("Background_lvl0.png")

	for i = 0, 20 do	
		table.insert(inventory, saw)
	end

	self.text = "A saw"
end

function level0State:draw()
	State.draw(self)

	drawInventory()
	love.graphics.print(self.text, 0, 140)

end

