class SVGHelper
  parse: (url, callback) ->
    $.ajax
      url: url
      success: (map) =>
        instruction_regex = new RegExp "([a-z])", "i"
        pathes = []
        for p in $("#layer1 path", $(map))
          path = $(p).attr("d").split instruction_regex
          path[i] = p.trim() for p, i in path
          path.splice(i, 1)  for p, i in path when p is ""
          path[i] = p.split " " for p, i in path when not p.match instruction_regex
          pathes.push path
        callback pathes

  fetchPolygones: (url, callback) ->
    @parse url, (pathes) ->
      result = []
      for path in pathes
        polygone = []
        position = null
        i = 0
        while i < path.length
          action = path[i]
          i++
          j = 0
          while i < path.length and j < path[i].length
            values = path[i][j].split(",")
            values[k] = parseFloat(values[k]) for v, k in values
            switch action
              when "M"
                polygone.unshift new b2Vec2 values[0], values[1]
              when "L"
                polygone.push new b2Vec2 values[0], values[1]
              when "l"
                polygone.push new b2Vec2 values[0] + polygone[polygone.length - 1].x, values[1] + polygone[polygone.length - 1].y
            j++
          i
        result.push polygone
      callback result

window.SVGHelper = SVGHelper
