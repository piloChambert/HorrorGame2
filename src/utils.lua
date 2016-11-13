function printOutlined(str, x, y, color, outlineColor)
    if not outlineColor then
        outlineColor = {0, 0, 0, 255}
    end

	love.graphics.setColor(unpack(outlineColor))
    love.graphics.print(str, x-1, y-1)
    love.graphics.print(str, x, y-1)
	love.graphics.print(str, x+1, y-1)
    love.graphics.print(str, x-1, y)
	love.graphics.print(str, x+1, y)
    love.graphics.print(str, x-1, y+1)
    love.graphics.print(str, x, y+1)
	love.graphics.print(str, x+1, y+1)

	love.graphics.setColor(unpack(color))	
    love.graphics.print(str, x, y)
end

function wait(time)
    while time > 0 do
        dt = coroutine.yield(true)
        time = time - dt
    end
end