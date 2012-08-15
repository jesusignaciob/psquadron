class Edificacion extends Entidad {
  int cant_armas;
  int estado;
  float proximoEstado;
  float armadura;
  boolean destruido;
  
  PImage[] sprites_dano;
  
  //  Instead of any of the usual variables, we will store a reference to a Box2D Body
  Body body;
  
  Edificacion(PImage[] _sprites_dano, int _x, int _y, int _ancho, int _alto, float _armadura) {
    super(_x, _y, _ancho, _alto);
    
    estado = _sprites_dano.length;
    proximoEstado = estado*(1.0);
    armadura = _armadura;
    
    sprites_dano = _sprites_dano;
    
    destruido = false;
    
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
    bd.position.set(box2d.coordPixelsToWorld(x + ancho/2, y + alto/2));
    body = box2d.createBody(bd);
    
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 100;
    fd.friction = 0.6;
    fd.restitution = 0.1;

    //Attach Fixture to Body						   
    body.createFixture(fd);
    
    body.setUserData(this);
  }
  
  boolean recibirDano(int dano) {
    println("  Dano: "+dano);
    println("  Armadura: "+armadura);
    println("  Proximo Estado: "+proximoEstado);
    proximoEstado -= (dano*(1.0) - armadura);
    boolean estaDestruido;
    estado = (estaDestruido = proximoEstado < 0) ? 0 : round(proximoEstado);
    println("  Estado: "+estado);
    
    return destruido = estaDestruido;
  }
  
  boolean estaDestruido() {
    return destruido;
  }
  
  // This function removes the particle from the box2d world
  void matarCuerpo() {
    box2d.destroyBody(body);
  }
  
  void display() {
    if (estado > 0) {
      if (ancho > 0 && alto > 0)
        image(sprites_dano[sprites_dano.length - estado], x, y, ancho, alto);
      else
        image(sprites_dano[sprites_dano.length - estado], x, y);
    }
  }
}
