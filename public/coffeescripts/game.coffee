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
    @map.update()
    for team in @teams
      team.update()

window.Game = Game
