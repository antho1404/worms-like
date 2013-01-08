(function() {
  var SVGHelper;

  SVGHelper = (function() {

    function SVGHelper() {}

    SVGHelper.prototype.parse = function(url, callback) {
      var _this = this;
      return $.ajax({
        url: url,
        success: function(map) {
          var i, instruction_regex, p, path, pathes, _i, _len, _len2, _len3, _len4, _ref;
          console.log(map);
          instruction_regex = new RegExp("([a-z])", "i");
          pathes = [];
          _ref = $("#layer1 path", $(map));
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            p = _ref[_i];
            path = $(p).attr("d").split(instruction_regex);
            for (i = 0, _len2 = path.length; i < _len2; i++) {
              p = path[i];
              path[i] = p.trim();
            }
            for (i = 0, _len3 = path.length; i < _len3; i++) {
              p = path[i];
              if (p === "") path.splice(i, 1);
            }
            for (i = 0, _len4 = path.length; i < _len4; i++) {
              p = path[i];
              if (!p.match(instruction_regex)) path[i] = p.split(" ");
            }
            pathes.push(path);
          }
          return callback(pathes);
        },
        error: function(e, a, z) {
          return console.log(e, a, z);
        }
      });
    };

    SVGHelper.prototype.fetchPolygones = function(url, callback) {
      return this.parse(url, function(pathes) {
        var action, i, j, k, path, polygone, position, result, v, values, _i, _len, _len2;
        result = [];
        for (_i = 0, _len = pathes.length; _i < _len; _i++) {
          path = pathes[_i];
          polygone = [];
          position = null;
          i = 0;
          while (i < path.length) {
            action = path[i];
            i++;
            j = 0;
            while (i < path.length && j < path[i].length) {
              values = path[i][j].split(",");
              for (k = 0, _len2 = values.length; k < _len2; k++) {
                v = values[k];
                values[k] = parseFloat(values[k]);
              }
              switch (action) {
                case "M":
                  polygone.unshift(new b2Vec2(values[0], values[1]));
                  break;
                case "L":
                  polygone.push(new b2Vec2(values[0], values[1]));
                  break;
                case "l":
                  polygone.push(new b2Vec2(values[0] + polygone[polygone.length - 1].x, values[1] + polygone[polygone.length - 1].y));
              }
              j++;
            }
            i;
          }
          result.push(polygone);
        }
        return callback(result);
      });
    };

    return SVGHelper;

  })();

  window.SVGHelper = SVGHelper;

}).call(this);
