import "CoreLibs/graphics"
import "CoreLibs/object"
import "game"

local gfx <const> = playdate.graphics

class("bee").extends()

function bee:init()
    self.this = {
        position = playdate.geometry.point.new(
            math.random(0, gameWidth),
            math.random(0, gameHeight)),
        velocity = playdate.geometry.point.new(0, 0),
        acceleration = playdate.geometry.point.new(0, 0),
		radius = 2,

        -- TODO: make these random
        rf = 0.00008,
        accelerationClamp = 0.639756,
        velocityClamp = 8.65701
	}
end

function bee:update(target)
    local this = self.this;

    local delta = target - this.position
    local distance = this.position:distanceToPoint(target)

    local accelerationRate = distance * this.rf;
    this.acceleration.x = delta.x * accelerationRate;
    this.acceleration.y = delta.y * accelerationRate;
    
    this.acceleration.x = clamp(this.acceleration.x, this.accelerationClamp);
    this.acceleration.y = clamp(this.acceleration.y, this.accelerationClamp);

    this.velocity.x = this.velocity.x + this.acceleration.x;
    this.velocity.y = this.velocity.y + this.acceleration.y;

    this.velocity.x = clamp(this.velocity.x, this.velocityClamp);
    this.velocity.y = clamp(this.velocity.y, this.velocityClamp);

    this.position.x += this.velocity.x;
    this.position.y += this.velocity.y;
end

function bee:draw()
    local this = self.this;
    gfx.drawCircleAtPoint(this.position.x, this.position.y, this.radius)
end

function clamp(value, limit)
    if value > limit then
        value = limit
    end

    if value < -limit then
        value = -limit
    end

    return value
end