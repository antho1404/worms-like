class Character
  constructor: (@team, number) ->
    @name   = number
    @life   = 100
    @weapon = null
    @body   = @createBody()

  createBody: ->
    fixDef  = DrawHelper.fixDef
    bodyDef = DrawHelper.bodyDef
    # app = App.getInstance()

    fixDef.shape       = new b2CircleShape(4)
    # fixDef.shape.SetAsBox 10, 10
    fixDef.density     = 1
    fixDef.friction    = 10
    fixDef.restitution = 0
    bodyDef.type = b2Body.b2_dynamicBody
    bodyDef.userData = "shape"
    bodyDef.position.Set Math.random()* 800, Math.random()*100
    bodyDef.fixedRotation = true
    body = app.world.CreateBody bodyDef
    # body.SetLinearVelocity new b2Vec2(Math.random() * 50 * (if Math.random() > 0.5 then -1 else 1), Math.random() * (if Math.random() > 0.5 then -1 else 1))
    # body.SetAngularVelocity Math.random() * 2 * Math.PI * (if Math.random() > 0.5 then -1 else 1)
    body.CreateFixture fixDef
    DrawHelper.restaure()
    body

  update: ->
    angle = @body.GetAngle() * 180 / Math.PI
    pos   = @body.GetPosition()
    App.getInstance()
    .canvas
    .drawRect({ strokeStyle: "black", strokeWidth: "1", x: pos.x - 10, y: pos.y - 20, width: 20, height: 5, fromCenter: false })
    .drawRect({ fillStyle: @team.color, x: pos.x - 10, y: pos.y - 20, width: 20 * @life / 100, height: 5, fromCenter: false })
    .drawText({ fillStyle: "black", x: pos.x, y: pos.y - 30, text: @name })

window.Character = Character
