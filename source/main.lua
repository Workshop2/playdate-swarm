import "bee"
import "game"
import "target"

local target = target()

local gfx<const> = playdate.graphics
local bees = {}

local function loadGame()
    playdate.display.setRefreshRate(50) -- Sets framerate to 50 fps
    math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random

    local numberOfBees = 3
    for i = 1, numberOfBees, 1 do
        table.insert(bees, bee())
    end
end

local function updateGame()
    if playdate.buttonIsPressed(playdate.kButtonA) then
        table.insert(bees, bee())
    end

    if playdate.buttonIsPressed(playdate.kButtonB) then
        table.remove(bees, #bees)
    end

    target:update();

    for index, value in pairs(bees) do
        value:update(target)
    end
end

local function drawGame()
    gfx.clear()
    target:draw();

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