(function() {
  var Map;

  Map = (function() {

    function Map(name) {
      var p;
      var _this = this;
      this.url = "/images/maps/" + name + ".svg";
      this.mapImg = $("img#map")[0];
      $(this.mapImg).attr("src", this.url);
      this.grounds = [];
      p = new SVGHelper;
      p.fetchPolygones(this.url, function(polygones) {
        var polygone, _i, _len;
        for (_i = 0, _len = polygones.length; _i < _len; _i++) {
          polygone = polygones[_i];
          _this.grounds.push(DrawHelper.createPolygone(polygone, b2Body.b2_staticBody, "ground"));
        }
      });
    }

    Map.prototype.update = function() {
      return App.getInstance().canvas.drawImage({
        source: this.mapImg,
        fromCenter: false
      });
    };

    return Map;

  })();

  window.Map = Map;

}).call(this);
