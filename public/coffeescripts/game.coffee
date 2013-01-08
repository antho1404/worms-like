class Game
  constructor: (map="dessin", teamNumber=2) ->
    @map = new Map(map)
    @teams = (new Team for i in [0..teamNumber-1])

  update: ->
    # b = app.world.GetBodyList()
    # while b
    #   angle = b.GetAngle()*(180/Math.PI)
    #   pos = b.GetPosition()
    #   switch b.GetUserData()
    #     when 'shape'
    #       app.canvas
    #       .rotateCanvas({ x:pos.x, y:pos.y, rotate: angle })
    #       .drawRect({ strokeStyle: "#333", strokeWidth: "1", x: pos.x, y: pos.y, width: 20, height: 20 })
    #       .drawRect({ fillStyle: "#ccc", x: pos.x, y: pos.y, width: 20, height: 20 })
    #       .restoreCanvas()
    #     when "ground"
    #       app.canvas
    #       .drawImage({ source: $("#map")[0], fromCenter: false })
    #   b = b.GetNext()
    # app.canvas.drawImage { source: $("#map")[0], fromCenter: false }

    @map.update()
    for team in @teams
      team.update()

window.Game = Game
