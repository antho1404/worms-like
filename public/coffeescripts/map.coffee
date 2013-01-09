class Map
  constructor: (name) ->
    @config = config["Map"]
    @url    = "#{@config.path}#{name}#{@config.extension}"
    @mapImg = $("img#map")[0]
    $(@mapImg).attr "src", @url

    @grounds = []
    p = new SVGHelper
    p.fetchPolygones @url, (polygones) =>
      for polygone in polygones
        @grounds.push DrawHelper.createPolygone polygone, b2Body.b2_staticBody, "ground"
      return

  update: ->
    App.getInstance().canvas.drawImage { source: @mapImg, fromCenter: false }

window.Map = Map
