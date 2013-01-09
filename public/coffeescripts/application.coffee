class App
  constructor: ->
    @config  = config["App"]
    @game    = null

    g        = new b2Vec2 0, @config.gravity
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

    window.setInterval (=> @update()), 1000 / 60

    $(document).keydown (e) =>
      @currentCharacter.moveRight() if e.keyCode is 39
      @currentCharacter.moveLeft()  if e.keyCode is 37
      @currentCharacter.jump()      if e.keyCode is 38
    $(document).keyup (e) =>
      @currentCharacter.stop() if e.keyCode is 39
      @currentCharacter.stop()  if e.keyCode is 37

  createGame: ->
    @game = new Game()
    @nextStep()

  nextStep: ->
    @currentCharacter = @game.nextStep()

  update: ->
    @world.Step 1 / 60, 10, 10
    @canvas.clearCanvas()
    @canvas.scaleCanvas({ x: @xshift, y: @yshift, scaleX: @zoom, scaleY: @zoom })
    @world.DrawDebugData() if config.DEBUG

    # @game.update()
    pos   = @currentCharacter.body.GetPosition()
    @canvas.drawArc({ fillStyle: "red", radius: 5, x: pos.x, y: pos.y })

    @canvas.restoreCanvas()
    @world.ClearForces()

App.getInstance = -> window.app ||= new App()

window.App = App
