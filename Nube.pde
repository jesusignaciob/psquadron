class Nube extends Entidad {
  
  private String sTextura;
  private GLModel glmNube;
  private GLTexture gltTextura;
  
  Nube(PApplet applet, String _sTextura, float _x, float _y, float _ancho, float _alto)
  {
    super(_x, _y, _ancho, _alto);
    
    sTextura = _sTextura;
    
    crearCuerpoGL(applet);
  }
  
  private void crearCuerpoGL(PApplet applet) {
    glmNube = new GLModel(applet, np, QUADS, GLModel.DYNAMIC);
    
    // Updating the vertices to their initial positions.
    glmNube.beginUpdateVertices();
    glmNube.updateVertex(0, 0, 0, 0);
    glmNube.updateVertex(1, ancho, 0, 0);
    glmNube.updateVertex(2, ancho, alto, 0);
    glmNube.updateVertex(3, 0, alto, 0);    
    glmNube.endUpdateVertices();
    
    // Enabling the use of texturing...
    glmNube.initTextures(1);
    // ... and loading and setting texture for this model.
    gltTextura = new GLTexture(applet, sTextura);
    glmNube.setTexture(0, gltTextura);
     
    // Setting the texture coordinates.
    glmNube.beginUpdateTexCoords(0);
    glmNube.updateTexCoord(0, 0, 0);
    glmNube.updateTexCoord(1, 1, 0);
    glmNube.updateTexCoord(2, 1, 1);
    glmNube.updateTexCoord(3, 0, 1);
    glmNube.endUpdateTexCoords();
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
      renderer.model(glmNube);
    popMatrix();
  }
}

