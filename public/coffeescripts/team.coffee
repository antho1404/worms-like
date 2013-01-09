class Team
  constructor: (id) ->
    @config     = config["Team"]
    @name       = @config.names[id]
    @color      = @config.colors[id]
    @characters = (new Character(@, i) for i in [0..@config.character_number-1])
    @current_characters = 0

  nextStep: ->
    @current_characters = (@current_characters + 1) % @characters.length
    @characters[@current_characters]

  update: ->
    for character in @characters
      character.update()

window.Team = Team
