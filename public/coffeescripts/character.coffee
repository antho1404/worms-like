class Character
  constructor: (@team, number) ->
    @config  = config["Character"]
    @name    = "worms#{number+1}"
    @life    = 100
    @body    = @createBody()

  isCurrent: -> @ is App.getInstance().currentCharacter

  moveRight: -> @body.SetAngularVelocity @config.angular_speed
  moveLeft:  -> @body.SetAngularVelocity -@config.angular_speed
  stop:      -> @body.SetAngularVelocity 0
  jump:      -> @body.ApplyForce new b2Vec2(0, -50000000), @body.GetWorldCenter()

  createBody: ->
    bodyDef               = DrawHelper.bodyDef
    bodyDef.type          = b2Body.b2_dynamicBody
    bodyDef.userData      = @name
    bodyDef.fixedRotation = true
    bodyDef.position.Set Math.random()* 800, Math.random()*100

    fixDef             = DrawHelper.fixDef
    fixDef.shape       = new b2CircleShape(10)
    fixDef.density     = @config.density
    fixDef.friction    = @config.friction
    fixDef.restitution = @config.restitution

    body = app.world.CreateBody bodyDef
    body.CreateFixture fixDef

    DrawHelper.restaure()
    body

  update: ->
    pos    = @body.GetPosition()
    canvas = App.getInstance().canvas
    canvas
      .drawRect({ strokeStyle: "black", strokeWidth: "1", x: pos.x - 15, y: pos.y - 20, width: 30, height: 5, fromCenter: false })
      .drawRect({ fillStyle: @team.color, x: pos.x - 15, y: pos.y - 20, width: 30 * @life / 100, height: 5, fromCenter: false })
      .drawText({ fillStyle: "black", x: pos.x, y: pos.y - 30, text: @name })
    if @isCurrent()
      canvas
        .drawArc({ fillStyle: "red", radius: 5, x: pos.x, y: pos.y })

window.Character = Character
