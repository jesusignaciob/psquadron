class Cordillera extends Entidad {
  private String sTextura;
  private GLModel glmCordillera;
  private GLTexture gltTextura;
  
  Cordillera(PApplet applet, String _sTextura, float _x, float _y, float _ancho, float _alto) {
    super(_x, _y, _ancho, _alto);
    sTextura = _sTextura;
    
    crearCuerpoGL(applet);
  }
  
  private void crearCuerpoGL(PApplet applet) {
    glmCordillera = new GLModel(applet, np, QUADS, GLModel.STATIC);
    
    // Updating the vertices to their initial positions.
    glmCordillera.beginUpdateVertices();
      glmCordillera.updateVertex(0, 0, 0, 0);
      glmCordillera.updateVertex(1, ancho, 0, 0);
      glmCordillera.updateVertex(2, ancho, alto, 0);
      glmCordillera.updateVertex(3, 0, alto, 0);
    glmCordillera.endUpdateVertices();
    
    // Enabling the use of texturing...
    glmCordillera.initTextures(1);
    // ... and loading and setting texture for this model.
    gltTextura = new GLTexture(applet, sTextura);    
    glmCordillera.setTexture(0, gltTextura);
     
    // Setting the texture coordinates.
    glmCordillera.beginUpdateTexCoords(0);
      glmCordillera.updateTexCoord(0, 0, 0);
      glmCordillera.updateTexCoord(1, 1, 0);    
      glmCordillera.updateTexCoord(2, 1, 1);
      glmCordillera.updateTexCoord(3, 0, 1);
    glmCordillera.endUpdateTexCoords();
  }
  
  void display(float speedx)
  {
    GLGraphics renderer = (GLGraphics)g;
    renderer.beginGL();
    
    display(renderer, speedx);
    
    renderer.endGL();
  }
  
  void display(GLGraphics renderer, float speedx)
  {
    pushMatrix();
      translate(x + speedx, y, 0);
      rectMode(CENTER);
      renderer.model(glmCordillera);
    popMatrix();
  }
}

