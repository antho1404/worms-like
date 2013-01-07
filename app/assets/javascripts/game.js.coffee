class Game
  constructor: (@map, @teams) ->
    @createGround()

  createGround: ->
    p = new SVGHelper
    p.fetchPolygones @map, (polygones) =>
      for polygone in polygones
        DrawHelper.createPolygone polygone, b2Body.b2_staticBody, "ground"
      return

  update: ->
    app = App.getInstance()
    b = app.world.GetBodyList()
    while b
      angle = b.GetAngle()*(180/Math.PI)
      pos = b.GetPosition()
      switch b.GetUserData()
        when 'shape'
          app.canvas
          .rotateCanvas({ x:pos.x, y:pos.y, rotate: angle })
          .drawRect({ strokeStyle: "#333", strokeWidth: "1", x: pos.x, y: pos.y, width: 20, height: 20 })
          .drawRect({ fillStyle: "#ccc", x: pos.x, y: pos.y, width: 20, height: 20 })
          .restoreCanvas()
        when "ground"
          app.canvas
          .drawImage({ source: $("#map")[0], fromCenter: false })
      b = b.GetNext()

window.Game = Game
