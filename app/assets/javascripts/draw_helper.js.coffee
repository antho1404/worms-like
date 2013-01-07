DrawHelper =
  createPolygone: (values, type=b2Body.b2_dynamicBody, userData) ->
    fixDef = App.getInstance().fixDef
    bodyDef = App.getInstance().bodyDef
    world = App.getInstance().world

    complex = Convex(values) is CONCAVE
    boxShape = new b2PolygonShape()

    values.reverse() if ClockWise(values) is CLOCKWISE

    fixDef.shape = new b2BodyDef();

    bodyDef.position.Set 0, 0
    bodyDef.type     = type
    bodyDef.userData = userData

    body = world.CreateBody bodyDef

    if complex and tmp = process(values)
      for t, i in tmp by 3
        boxShape = new b2PolygonShape()
        boxShape.SetAsArray [tmp[i], tmp[i + 1], tmp[i + 2]]
        fixDef = new b2FixtureDef()
        fixDef.shape = boxShape;

        body.CreateFixture fixDef
    else
      boxShape.SetAsArray values, values.length
      fixDef.shape = boxShape

      body.CreateFixture fixDef

window.DrawHelper = DrawHelper
