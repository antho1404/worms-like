class Team
  constructor: (@name, @color, number=4) ->
    @characters = (new Character(@, i) for i in [0..number-1])
    @current_characters = 0

  nextStep: ->
    @current_characters = (@current_characters + 1) % @characters.length
    @characters[@current_characters]

  update: ->
    for character in @characters
      character.update()

window.Team = Team
