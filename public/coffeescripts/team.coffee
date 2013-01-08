class Team
  constructor: (@name, @color, number=4) ->
    @characters = (new Character for i in [0..number-1])

  update: ->
    for character in @characters
      character.update()

window.Team = Team
