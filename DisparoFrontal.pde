class DisparoFrontal extends Arma {
  
  DisparoFrontal(PImage _sprite, int _id, String _nombre, float _x, float _y, int _ancho, int _alto, int _dano) {
    super(_id, _nombre, _x, _y, _ancho, _alto, _dano);
    
    sprite = _sprite;
    
    makeBody();
  }
  
  DisparoFrontal(PImage _sprite, int _id, String _nombre, float _x, float _y, int _dano) {
    super(_id, _nombre, _x, _y, _sprite.width, _sprite.height, _dano);
    
    sprite = _sprite;
    
    makeBody();
  }
  
  void makeBody() {
    // Build Body
    BodyDef bd = new BodyDef();			
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(ancho/2);
    float box2dH = box2d.scalarPixelsToWorld(alto/2);	// Box2D considers the width and height of a
    sd.setAsBox(box2dW, box2dH);		        // rectangle to be the distance from the
					// center to the edge (so half of what we
                					// normally think of as width or height.) 
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 10;
    fd.friction = 0.6;
    fd.restitution = 0;

    //Attach Fixture to Body						   
    body.createFixture(fd);
    
    // Give it some initial random velocity
    body.setLinearVelocity(new Vec2(100, -70));
    body.setAngularVelocity(-1);
    
    body.setUserData(this);
  }
  
  void display() {
    // We need the Body’s location and angle
    Vec2 pos = box2d.getBodyPixelCoord(body);		
    float a = body.getAngle();
    
    pushMatrix();
      translate(pos.x, pos.y);		// Using the Vec2 position and float angle to
      rotate(-a);			        // translate and rotate the rectangle
      rectMode(CENTER);
      image(sprite, -sprite.width/2, -sprite.height/2);
    popMatrix();
  }
}
