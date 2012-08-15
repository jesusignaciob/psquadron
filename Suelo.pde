class Suelo extends Entidad {
  PImage suelo;
  
  // But we also have to make a body for box2d to know about it
  Body body;

  Suelo(PImage _suelo, float _x,float _y, float _ancho, float _alto) {
    super(_x, _y, _ancho, _alto);
    
    suelo = _suelo;

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(ancho/2);
    float box2dH = box2d.scalarPixelsToWorld(alto/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x + ancho/2, y + alto/2 + 50));
    body = box2d.createBody(bd);
    
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 10000;
    fd.friction = 0.6;
    fd.restitution = 0.1;

    //Attach Fixture to Body						   
    body.createFixture(fd);
    
    body.setUserData(this);
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    //rect(x,y,ancho,alto);
    //image(suelo, x, y);
    image(suelo, x, y);
  }
}
