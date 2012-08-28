class Suelo extends Entidad {
  PImage suelo;
  
  private String sTextura;
  private GLModel glmSuelo;
  private GLTexture gltTextura;
  
  int np;
  
  // But we also have to make a body for box2d to know about it
  Body body;

  Suelo(PApplet applet, String _sTextura, int _np, float _x, float _y, float _ancho, float _alto) {
    super(_x, _y, _ancho, _alto);
    
    sTextura = _sTextura;
    np = _np < 1 ? 1 : _np;
    
    int ANCHO_REAL = round(np * ancho);
    
    crearCuerpoGL(applet, ANCHO_REAL);
    
    makeBody();
  }
  
  void makeBody() {
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

  private void crearCuerpoGL(PApplet applet, int _ancho) {
    try {
      glmSuelo = new GLModel(applet, np, QUADS, GLModel.STATIC);
      
      // Updating the vertices to their initial positions.
      glmSuelo.beginUpdateVertices();
        glmSuelo.updateVertex(0, 0, 0, 0);
        glmSuelo.updateVertex(1, _ancho, 0, 0);
        glmSuelo.updateVertex(2, _ancho, alto, 0);
        glmSuelo.updateVertex(3, 0, alto, 0);    
      glmSuelo.endUpdateVertices();
      
      // Enabling the use of texturing...
      glmSuelo.initTextures(1);
      // ... and loading and setting texture for this model.
      gltTextura = new GLTexture(applet, sTextura);    
      glmSuelo.setTexture(0, gltTextura);
       
      // Setting the texture coordinates.
      glmSuelo.beginUpdateTexCoords(0);
        glmSuelo.updateTexCoord(0, 0, 0);
        glmSuelo.updateTexCoord(1, 1, 0);    
        glmSuelo.updateTexCoord(2, 1, 1);
        glmSuelo.updateTexCoord(3, 0, 1);
      glmSuelo.endUpdateTexCoords();
    } catch(Exception e) {
      println(e);
    }
  }
  
  void display()
  {
    try {
      GLGraphics renderer = (GLGraphics)g;
      renderer.beginGL(); 
      
      pushMatrix();
      translate(x, y, 0);
      renderer.model(glmSuelo);
      popMatrix();
      
      renderer.endGL();
    } catch(Exception e) {
      println(e);
    }
  }
}

