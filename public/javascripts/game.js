(function() {
  var Game;

  Game = (function() {

    function Game(map, teamNumber) {
      var i;
      if (map == null) map = "dessin";
      if (teamNumber == null) teamNumber = 2;
      this.map = new Map(map);
      this.teams = (function() {
        var _ref, _results;
        _results = [];
        for (i = 0, _ref = teamNumber - 1; 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
          _results.push(new Team);
        }
        return _results;
      })();
    }

    Game.prototype.update = function() {
      var team, _i, _len, _ref, _results;
      this.map.update();
      _ref = this.teams;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        team = _ref[_i];
        _results.push(team.update());
      }
      return _results;
    };

    return Game;

  })();

  window.Game = Game;

}).call(this);
