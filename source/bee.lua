import "CoreLibs/graphics"
import "CoreLibs/object"
import "game"
import "target"

local gfx<const> = playdate.graphics

class("bee").extends()

function bee:init()
    self.this = {
        position = playdate.geometry.point.new(math.random(0, gameWidth), math.random(0, gameHeight)),
        velocity = playdate.geometry.point.new(0, 0),
        acceleration = playdate.geometry.point.new(0, 0),
        radius = 2,

        -- Randoms
        rf = math.random(2, 9) * 0.00001,
        accelerationClamp = diffuse(0.3),
        velocityClamp = diffuse(5)
    }
end

function bee:update(target)
    local this = self.this;
    local targetPosition = target:position()

    local delta = targetPosition - this.position
    local distance = this.position:distanceToPoint(targetPosition)

    local accelerationRate = distance * this.rf;
    this.acceleration.x = delta.x * accelerationRate;
    this.acceleration.y = delta.y * accelerationRate;

    this.acceleration.x = clamp(this.acceleration.x, this.accelerationClamp);
    this.acceleration.y = clamp(this.acceleration.y, this.accelerationClamp);

    this.velocity.x = this.velocity.x + this.acceleration.x;
    this.velocity.y = this.velocity.y + this.acceleration.y;

    this.velocity.x = clamp(this.velocity.x, this.velocityClamp);
    this.velocity.y = clamp(this.velocity.y, this.velocityClamp);

    this.position.x = this.position.x + this.velocity.x;
    this.position.y = this.position.y + this.velocity.y;
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

function diffuse(value)
    return value * (math.random(085, 115) * 0.01);
end