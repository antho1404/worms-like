(function() {
  var Team;

  Team = (function() {

    function Team(name, color, number) {
      var i;
      this.name = name;
      this.color = color;
      if (number == null) number = 4;
      this.characters = (function() {
        var _ref, _results;
        _results = [];
        for (i = 0, _ref = number - 1; 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
          _results.push(new Character);
        }
        return _results;
      })();
    }

    Team.prototype.update = function() {
      var character, _i, _len, _ref, _results;
      _ref = this.characters;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        character = _ref[_i];
        _results.push(character.update());
      }
      return _results;
    };

    return Team;

  })();

  window.Team = Team;

}).call(this);
