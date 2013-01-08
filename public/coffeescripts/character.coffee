class Character
  constructor: ->
    @name   = ""
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

  update: ->
    # console.log app.world

window.Character = Character
