DrawHelper =
  bodyDef: null
  fixDef: null,

  restaure: ->
    @fixDef.density        = 1
    @fixDef.friction       = 0.5
    @fixDef.restitution    = 0.2
    @bodyDef.fixedRotation = false

  createPolygone: (values, type=b2Body.b2_dynamicBody, userData) ->
    world = App.getInstance().world

    complex = Convex(values) is CONCAVE
    boxShape = new b2PolygonShape()

    values.reverse() if ClockWise(values) is CLOCKWISE

    @fixDef.shape = new b2BodyDef();

    @bodyDef.position.Set 0, 0
    @bodyDef.type     = type
    @bodyDef.userData = userData

    body = world.CreateBody @bodyDef

    if complex and tmp = process(values)
      for t, i in tmp by 3
        boxShape = new b2PolygonShape()
        boxShape.SetAsArray [tmp[i], tmp[i + 1], tmp[i + 2]]
        @fixDef = new b2FixtureDef()
        @fixDef.shape = boxShape;
        @fixDef.density     = 1
        @fixDef.friction    = 1
        @fixDef.restitution = 0

        body.CreateFixture @fixDef
    else
      boxShape.SetAsArray values, values.length
      @fixDef.shape = boxShape

      body.CreateFixture @fixDef

$(document).ready ->
  DrawHelper.bodyDef = new b2BodyDef()
  DrawHelper.fixDef  = new b2FixtureDef()
  DrawHelper.restaure()

window.DrawHelper = DrawHelper
