class App
  constructor: ->
    @game    = null

    g        = new b2Vec2 0, 100
    @world   = new b2World g, true

    @canvas = $("#canvas")
    @ctx    = document.getElementById("canvas").getContext("2d")
    @height = document.getElementById("canvas").height
    @width  = document.getElementById("canvas").width
    if config.DEBUG
      debugDraw = new b2DebugDraw()
      debugDraw.SetSprite @ctx
      debugDraw.SetDrawScale 1
      debugDraw.SetFillAlpha 0.5
      debugDraw.SetLineThickness 1.0
      debugDraw.SetFlags b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit
      @world.SetDebugDraw debugDraw
    # @createObjects()

    window.setInterval (=> @update()), 1000 / 60

    @canvas.click (e) => @createObjects(e.clientX, e.clientY)

  createGame: ->
    @game = new Game()

  createObjects: (x=(Math.random() * @width), y=(Math.random() * @height)) ->
    fixDef  = DrawHelper.fixDef
    bodyDef = DrawHelper.bodyDef

    fixDef.shape       = new b2PolygonShape
    fixDef.shape.SetAsBox 10, 10
    fixDef.density     = 1
    fixDef.friction    = 10
    fixDef.restitution = 0
    bodyDef.type = b2Body.b2_dynamicBody
    bodyDef.userData = "shape"
    bodyDef.position.Set x, y
    body = @world.CreateBody bodyDef
    # body.SetLinearVelocity new b2Vec2(Math.random() * 50 * (if Math.random() > 0.5 then -1 else 1), Math.random() * (if Math.random() > 0.5 then -1 else 1))
    # body.SetAngularVelocity Math.random() * 2 * Math.PI * (if Math.random() > 0.5 then -1 else 1)
    body.CreateFixture fixDef

  update: ->
    @world.Step 1 / 60, 10, 10
    @canvas.clearCanvas()
    @canvas.scaleCanvas({ x: @xshift, y: @yshift, scaleX: @zoom, scaleY: @zoom })
    @world.DrawDebugData() if config.DEBUG

    @game.update()

    @canvas.restoreCanvas()
    @world.ClearForces()

App.getInstance = -> window.app ||= new App()

window.App = App

$(document).ready ->

