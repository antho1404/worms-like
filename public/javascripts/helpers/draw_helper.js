(function() {
  var DrawHelper;

  DrawHelper = {
    bodyDef: null,
    fixDef: null,
    restaure: function() {
      this.fixDef.density = 1;
      this.fixDef.friction = 0.5;
      this.fixDef.restitution = 0.2;
      return this.bodyDef.fixedRotation = false;
    },
    createPolygone: function(values, type, userData) {
      var body, boxShape, complex, i, t, tmp, world, _len, _results, _step;
      if (type == null) type = b2Body.b2_dynamicBody;
      world = App.getInstance().world;
      complex = Convex(values) === CONCAVE;
      boxShape = new b2PolygonShape();
      if (ClockWise(values) === CLOCKWISE) values.reverse();
      this.fixDef.shape = new b2BodyDef();
      this.bodyDef.position.Set(0, 0);
      this.bodyDef.type = type;
      this.bodyDef.userData = userData;
      body = world.CreateBody(this.bodyDef);
      if (complex && (tmp = process(values))) {
        _results = [];
        for (i = 0, _len = tmp.length, _step = 3; i < _len; i += _step) {
          t = tmp[i];
          boxShape = new b2PolygonShape();
          boxShape.SetAsArray([tmp[i], tmp[i + 1], tmp[i + 2]]);
          this.fixDef = new b2FixtureDef();
          this.fixDef.shape = boxShape;
          this.fixDef.density = 1;
          this.fixDef.friction = 1;
          this.fixDef.restitution = 0;
          _results.push(body.CreateFixture(this.fixDef));
        }
        return _results;
      } else {
        boxShape.SetAsArray(values, values.length);
        this.fixDef.shape = boxShape;
        return body.CreateFixture(this.fixDef);
      }
    }
  };

  $(document).ready(function() {
    DrawHelper.bodyDef = new b2BodyDef();
    DrawHelper.fixDef = new b2FixtureDef();
    return DrawHelper.restaure();
  });

  window.DrawHelper = DrawHelper;

}).call(this);
