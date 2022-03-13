import "bee"
import "game"

local target = playdate.geometry.point.new(gameWidth / 2, gameHeight / 2)

local gfx<const> = playdate.graphics
local bees = {}

local function loadGame()
    playdate.display.setRefreshRate(50) -- Sets framerate to 50 fps
    math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random

    for i = 1, 10, 1 do
        table.insert(bees, bee())
    end
end

local function updateGame()
    for index, value in pairs(bees) do
        value:update(target)
    end
end

local function drawGame()
    gfx.clear()

    for index, value in pairs(bees) do
        value:draw()
    end
end

function playdate.update()
    updateGame()
    drawGame()
    playdate.drawFPS(0, 0) -- FPS widget
end

loadGame()