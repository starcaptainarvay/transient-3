---@meta
---@module 'love.physics'

--- Provides an interface to create and control physics objects.
---@class love.physics
love.physics = {}

--- Creates a new Body.
---@param world love.physics.World The world to create the body in.
---@param x number The x position of the body.
---@param y number The y position of the body.
---@param type love.physics.BodyType The type of the body.
---@return love.physics.Body body The new body.
function love.physics.newBody(world, x, y, type) end

--- Creates a new ChainShape.
---@param loop boolean Whether the shape should be a loop.
---@param ... number The vertices of the chain.
---@return love.physics.ChainShape chainShape The new shape.
function love.physics.newChainShape(loop, ...) end

--- Creates a new CircleShape.
---@param radius number The radius of the circle.
---@return love.physics.CircleShape circleShape The new shape.
function love.physics.newCircleShape(radius) end

--- Creates a new DistanceJoint.
---@param body1 love.physics.Body The first body.
---@param body2 love.physics.Body The second body.
---@param x1 number The x position of the first anchor point.
---@param y1 number The y position of the first anchor point.
---@param x2 number The x position of the second anchor point.
---@param y2 number The y position of the second anchor point.
---@param collideConnected boolean Whether the bodies should collide with each other.
---@return love.physics.DistanceJoint distanceJoint The new joint.
function love.physics.newDistanceJoint(body1, body2, x1, y1, x2, y2, collideConnected) end

--- Creates a new EdgeShape.
---@param x1 number The x position of the first vertex.
---@param y1 number The y position of the first vertex.
---@param x2 number The x position of the second vertex.
---@param y2 number The y position of the second vertex.
---@return love.physics.EdgeShape edgeShape The new shape.
function love.physics.newEdgeShape(x1, y1, x2, y2) end

--- Creates a new Fixture.
---@param body love.physics.Body The body to attach the fixture to.
---@param shape love.physics.Shape The shape of the fixture.
---@param density number The density of the fixture.
---@return love.physics.Fixture fixture The new fixture.
function love.physics.newFixture(body, shape, density) end

--- Creates a new FrictionJoint.
---@param body1 love.physics.Body The first body.
---@param body2 love.physics.Body The second body.
---@param x number The x position of the anchor point.
---@param y number The y position of the anchor point.
---@param collideConnected boolean Whether the bodies should collide with each other.
---@return love.physics.FrictionJoint frictionJoint The new joint.
function love.physics.newFrictionJoint(body1, body2, x, y, collideConnected) end

--- Creates a new GearJoint.
---@param joint1 love.physics.Joint The first joint.
---@param joint2 love.physics.Joint The second joint.
---@param ratio number The gear ratio.
---@return love.physics.GearJoint gearJoint The new joint.
function love.physics.newGearJoint(joint1, joint2, ratio) end

--- Creates a new MouseJoint.
---@param body love.physics.Body The body to attach the joint to.
---@param x number The x position of the target.
---@param y number The y position of the target.
---@return love.physics.MouseJoint mouseJoint The new joint.
function love.physics.newMouseJoint(body, x, y) end

--- Creates a new PolygonShape.
---@param ... number The vertices of the polygon.
---@return love.physics.PolygonShape polygonShape The new shape.
function love.physics.newPolygonShape(...) end

--- Creates a new PrismaticJoint.
---@param body1 love.physics.Body The first body.
---@param body2 love.physics.Body The second body.
---@param x number The x position of the anchor point.
---@param y number The y position of the anchor point.
---@param ax number The x position of the axis.
---@param ay number The y position of the axis.
---@param collideConnected boolean Whether the bodies should collide with each other.
---@return love.physics.PrismaticJoint prismaticJoint The new joint.
function love.physics.newPrismaticJoint(body1, body2, x, y, ax, ay, collideConnected) end

--- Creates a new PulleyJoint.
---@param body1 love.physics.Body The first body.
---@param body2 love.physics.Body The second body.
---@param gx1 number The x position of the first ground anchor.
---@param gy1 number The y position of the first ground anchor.
---@param gx2 number The x position of the second ground anchor.
---@param gy2 number The y position of the second ground anchor.
---@param x1 number The x position of the first anchor point.
---@param y1 number The y position of the first anchor point.
---@param x2 number The x position of the second anchor point.
---@param y2 number The y position of the second anchor point.
---@param ratio number The pulley ratio.
---@param collideConnected boolean Whether the bodies should collide with each other.
---@return love.physics.PulleyJoint pulleyJoint The new joint.
function love.physics.newPulleyJoint(body1, body2, gx1, gy1, gx2, gy2, x1, y1, x2, y2, ratio, collideConnected) end

--- Creates a new RevoluteJoint.
---@param body1 love.physics.Body The first body.
---@param body2 love.physics.Body The second body.
---@param x number The x position of the anchor point.
---@param y number The y position of the anchor point.
---@param collideConnected boolean Whether the bodies should collide with each other.
---@return love.physics.RevoluteJoint revoluteJoint The new joint.
function love.physics.newRevoluteJoint(body1, body2, x, y, collideConnected) end

--- Creates a new RopeJoint.
---@param body1 love.physics.Body The first body.
---@param body2 love.physics.Body The second body.
---@param x1 number The x position of the first anchor point.
---@param y1 number The y position of the first anchor point.
---@param x2 number The x position of the second anchor point.
---@param y2 number The y position of the second anchor point.
---@param maxLength number The maximum length of the rope.
---@param collideConnected boolean Whether the bodies should collide with each other.
---@return love.physics.RopeJoint ropeJoint The new joint.
function love.physics.newRopeJoint(body1, body2, x1, y1, x2, y2, maxLength, collideConnected) end

--- Creates a new Shape.
---@param shapeType love.physics.ShapeType The type of the shape.
---@param ... number The arguments for the shape constructor.
---@return love.physics.Shape shape The new shape.
function love.physics.newShape(shapeType, ...) end

--- Creates a new WeldJoint.
---@param body1 love.physics.Body The first body.
---@param body2 love.physics.Body The second body.
---@param x number The x position of the anchor point.
---@param y number The y position of the anchor point.
---@param collideConnected boolean Whether the bodies should collide with each other.
---@return love.physics.WeldJoint weldJoint The new joint.
function love.physics.newWeldJoint(body1, body2, x, y, collideConnected) end

--- Creates a new WheelJoint.
---@param body1 love.physics.Body The first body.
---@param body2 love.physics.Body The second body.
---@param x number The x position of the anchor point.
---@param y number The y position of the anchor point.
---@param ax number The x position of the axis.
---@param ay number The y position of the axis.
---@param collideConnected boolean Whether the bodies should collide with each other.
---@return love.physics.WheelJoint wheelJoint The new joint.
function love.physics.newWheelJoint(body1, body2, x, y, ax, ay, collideConnected) end

--- Creates a new World.
---@param x number The x component of gravity.
---@param y number The y component of gravity.
---@param sleep boolean Whether the bodies in the world are allowed to sleep.
---@return love.physics.World world The new world.
function love.physics.newWorld(x, y, sleep) end

--- Sets the meter scale factor.
---@param scale number The new scale factor.
function love.physics.setMeter(scale) end

--- Gets the meter scale factor.
---@return number scale The meter scale factor.
function love.physics.getMeter() end

---@class love.physics.Body
local Body = {}

--- Gets the world the body lives in.
---@return love.physics.World world The world the body lives in.
function Body:getWorld() end

--- Sets the position of the body.
---@param x number The new x position of the body.
---@param y number The new y position of the body.
function Body:setPosition(x, y) end

--- Gets the position of the body.
---@return number x The x position of the body.
---@return number y The y position of the body.
function Body:getPosition() end

--- Sets the velocity of the body.
---@param x number The new x velocity of the body.
---@param y number The new y velocity of the body.
function Body:setLinearVelocity(x, y) end

--- Gets the velocity of the body.
---@return number x The x velocity of the body.
---@return number y The y velocity of the body.
function Body:getLinearVelocity() end

--- Sets the angular velocity of the body.
---@param omega number The new angular velocity of the body.
function Body:setAngularVelocity(omega) end

--- Gets the angular velocity of the body.
---@return number omega The angular velocity of the body.
function Body:getAngularVelocity() end

--- Applies a force to the body.
---@param fx number The x component of the force.
---@param fy number The y component of the force.
---@param x number The x position to apply the force at.
---@param y number The y position to apply the force at.
function Body:applyForce(fx, fy, x, y) end

--- Applies a torque to the body.
---@param torque number The torque to apply.
function Body:applyTorque(torque) end

--- Sets the mass of the body.
---@param mass number The new mass of the body.
function Body:setMass(mass) end

--- Gets the mass of the body.
---@return number mass The mass of the body.
function Body:getMass() end

---@class love.physics.World
local World = {}

--- Updates the world.
---@param dt number The time step to use for the update.
function World:update(dt) end

--- Gets the gravity of the world.
---@return number x The x component of gravity.
---@return number y The y component of gravity.
function World:getGravity() end

--- Sets the gravity of the world.
---@param x number The new x component of gravity.
---@param y number The new y component of gravity.
function World:setGravity(x, y) end

--- Destroys the world and all bodies in it.
function World:destroy() end

---@class love.physics.Shape
local Shape = {}

--- Gets the type of the shape.
---@return love.physics.ShapeType type The type of the shape.
function Shape:getType() end

--- Sets the radius of the shape.
---@param radius number The new radius of the shape.
function Shape:setRadius(radius) end

--- Gets the radius of the shape.
---@return number radius The radius of the shape.
function Shape:getRadius() end

---@class love.physics.Fixture
local Fixture = {}

--- Sets the density of the fixture.
---@param density number The new density of the fixture.
function Fixture:setDensity(density) end

--- Gets the density of the fixture.
---@return number density The density of the fixture.
function Fixture:getDensity() end

--- Sets the friction of the fixture.
---@param friction number The new friction of the fixture.
function Fixture:setFriction(friction) end

--- Gets the friction of the fixture.
---@return number friction The friction of the fixture.
function Fixture:getFriction() end

---@class love.physics.Joint
local Joint = {}

--- Gets the type of the joint.
---@return love.physics.JointType type The type of the joint.
function Joint:getType() end

---@class love.physics.DistanceJoint : love.physics.Joint
local DistanceJoint = {}

--- Sets the length of the distance joint.
---@param length number The new length of the distance joint.
function DistanceJoint:setLength(length) end

--- Gets the length of the distance joint.
---@return number length The length of the distance joint.
function DistanceJoint:getLength() end

---@class love.physics.PrismaticJoint : love.physics.Joint
local PrismaticJoint = {}

--- Sets the limits of the prismatic joint.
---@param lower number The lower limit.
---@param upper number The upper limit.
function PrismaticJoint:setLimits(lower, upper) end

--- Gets the limits of the prismatic joint.
---@return number lower The lower limit.
---@return number upper The upper limit.
function PrismaticJoint:getLimits() end

---@class love.physics.PulleyJoint : love.physics.Joint
local PulleyJoint = {}

--- Gets the length of the rope segment attached to the first body.
---@return number length1 The length of the rope segment attached to the first body.
function PulleyJoint:getLength1() end

--- Gets the length of the rope segment attached to the second body.
---@return number length2 The length of the rope segment attached to the second body.
function PulleyJoint:getLength2() end

---@class love.physics.RevoluteJoint : love.physics.Joint
local RevoluteJoint = {}

--- Sets the limits of the revolute joint.
---@param lower number The lower limit.
---@param upper number The upper limit.
function RevoluteJoint:setLimits(lower, upper) end

--- Gets the limits of the revolute joint.
---@return number lower The lower limit.
---@return number upper The upper limit.
function RevoluteJoint:getLimits() end

---@class love.physics.RopeJoint : love.physics.Joint
local RopeJoint = {}

--- Sets the maximum length of the rope joint.
---@param maxLength number The new maximum length.
function RopeJoint:setMaxLength(maxLength) end

--- Gets the maximum length of the rope joint.
---@return number maxLength The maximum length.
function RopeJoint:getMaxLength() end

---@class love.physics.WeldJoint : love.physics.Joint
local WeldJoint = {}

--- Sets the frequency of the weld joint.
---@param frequency number The new frequency.
function WeldJoint:setFrequency(frequency) end

--- Gets the frequency of the weld joint.
---@return number frequency The frequency.
function WeldJoint:getFrequency() end

---@class love.physics.WheelJoint : love.physics.Joint
local WheelJoint = {}

--- Sets the motor speed of the wheel joint.
---@param speed number The new motor speed.
function WheelJoint:setMotorSpeed(speed) end

--- Gets the motor speed of the wheel joint.
---@return number speed The motor speed.
function WheelJoint:getMotorSpeed() end

---@class love.physics.MouseJoint : love.physics.Joint
local MouseJoint = {}

--- Sets the target position of the mouse joint.
---@param x number The new x position of the target.
---@param y number The new y position of the target.
function MouseJoint:setTarget(x, y) end

--- Gets the target position of the mouse joint.
---@return number x The x position of the target.
---@return number y The y position of the target.
function MouseJoint:getTarget() end

---@alias love.physics.BodyType string
--- The types of bodies.
love.physics.BodyType = {
    "static",
    "dynamic",
    "kinematic",
}

---@alias love.physics.ShapeType string
--- The types of shapes.
love.physics.ShapeType = {
    "circle",
    "polygon",
    "edge",
    "chain",
}

---@alias love.physics.JointType string
--- The types of joints.
love.physics.JointType = {
    "distance",
    "prismatic",
    "pulley",
    "revolute",
    "rope",
    "weld",
    "wheel",
    "mouse",
    "gear",
    "friction",
}

return love.physics
