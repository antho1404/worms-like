(function() {
  var Character;

  Character = (function() {

    function Character() {
      this.name = "";
      this.life = 100;
      this.weapon = null;
      this.body = this.createBody();
    }

    Character.prototype.createBody = function() {
      var body, bodyDef, fixDef;
      fixDef = DrawHelper.fixDef;
      bodyDef = DrawHelper.bodyDef;
      fixDef.shape = new b2CircleShape(4);
      fixDef.density = 1;
      fixDef.friction = 10;
      fixDef.restitution = 0;
      bodyDef.type = b2Body.b2_dynamicBody;
      bodyDef.userData = "shape";
      bodyDef.position.Set(Math.random() * 800, Math.random() * 100);
      bodyDef.fixedRotation = true;
      body = app.world.CreateBody(bodyDef);
      body.CreateFixture(fixDef);
      return DrawHelper.restaure();
    };

    Character.prototype.update = function() {};

    return Character;

  })();

  window.Character = Character;

}).call(this);
