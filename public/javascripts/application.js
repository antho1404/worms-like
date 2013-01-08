(function() {
  var App;

  App = (function() {

    function App() {
      var debugDraw, g;
      var _this = this;
      this.game = null;
      g = new b2Vec2(0, 100);
      this.world = new b2World(g, true);
      this.canvas = $("#canvas");
      this.ctx = document.getElementById("canvas").getContext("2d");
      this.height = document.getElementById("canvas").height;
      this.width = document.getElementById("canvas").width;
      if (config.DEBUG) {
        debugDraw = new b2DebugDraw();
        debugDraw.SetSprite(this.ctx);
        debugDraw.SetDrawScale(1);
        debugDraw.SetFillAlpha(0.5);
        debugDraw.SetLineThickness(1.0);
        debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
        this.world.SetDebugDraw(debugDraw);
      }
      window.setInterval((function() {
        return _this.update();
      }), 1000 / 60);
      this.canvas.click(function(e) {
        return _this.createObjects(e.clientX, e.clientY);
      });
    }

    App.prototype.createGame = function() {
      return this.game = new Game();
    };

    App.prototype.createObjects = function(x, y) {
      var body, bodyDef, fixDef;
      if (x == null) x = Math.random() * this.width;
      if (y == null) y = Math.random() * this.height;
      fixDef = DrawHelper.fixDef;
      bodyDef = DrawHelper.bodyDef;
      fixDef.shape = new b2PolygonShape;
      fixDef.shape.SetAsBox(10, 10);
      fixDef.density = 1;
      fixDef.friction = 10;
      fixDef.restitution = 0;
      bodyDef.type = b2Body.b2_dynamicBody;
      bodyDef.userData = "shape";
      bodyDef.position.Set(x, y);
      body = this.world.CreateBody(bodyDef);
      return body.CreateFixture(fixDef);
    };

    App.prototype.update = function() {
      this.world.Step(1 / 60, 10, 10);
      this.canvas.clearCanvas();
      this.canvas.scaleCanvas({
        x: this.xshift,
        y: this.yshift,
        scaleX: this.zoom,
        scaleY: this.zoom
      });
      if (config.DEBUG) this.world.DrawDebugData();
      this.game.update();
      this.canvas.restoreCanvas();
      return this.world.ClearForces();
    };

    return App;

  })();

  App.getInstance = function() {
    return window.app || (window.app = new App());
  };

  window.App = App;

  $(document).ready(function() {});

}).call(this);
