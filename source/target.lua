import "CoreLibs/graphics"
import "CoreLibs/object"
import "game"

local gfx<const> = playdate.graphics

class("target").extends()

local speed<const> = 4;

function target:init()
    self.this = {
        position = playdate.geometry.point.new(
        gameWidth / 2,
        gameHeight / 2)
    }
end

function target:update()
    if playdate.buttonIsPressed(playdate.kButtonUp) then
        self.this.position.y -= speed
    end
    if playdate.buttonIsPressed(playdate.kButtonDown) then
        self.this.position.y += speed
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        self.this.position.x -= speed
    end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        self.this.position.x += speed
    end
end

function target:draw()
    gfx.drawCircleAtPoint(self.this.position.x - 2, self.this.position.y - 2, 4)
end

function target:position()
    return self.this.position
end