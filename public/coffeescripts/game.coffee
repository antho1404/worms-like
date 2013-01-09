class Game
  constructor: (map="dessin", teamNumber) ->
    @config = config["Game"]
    @map    = new Map(map)
    @teams  = (new Team(i) for i in [0..@config.team_number-1])
    @current_team = 0

  nextStep: ->
    @current_team = (@current_team + 1) % @teams.length
    @teams[@current_team].nextStep()

  update: ->
    @map.update()
    for team in @teams
      team.update()

window.Game = Game
