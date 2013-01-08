class Game
  constructor: (map="dessin", teamNumber=2) ->
    colors = ["red", "blue", "green", "orange"]
    @map = new Map(map)
    @teams = (new Team(colors[i], colors[i]) for i in [0..teamNumber-1])
    @current_team = 0

  nextStep: ->
    @current_team = (@current_team + 1) % @teams.length
    @teams[@current_team].nextStep()

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
