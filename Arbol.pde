class Arbol extends Entidad {
  
  private String sTextura;
  private GLModel glmArbol;
  private GLTexture gltTextura;
  
  Arbol(PApplet applet, String _sTextura, float _x, float _y, float _ancho, float _alto) {
    super(_x, _y, _ancho, _alto);
    sTextura = _sTextura;
    
    crearCuerpoGL(applet);
  }
  
  private void crearCuerpoGL(PApplet applet) {
    glmArbol = new GLModel(applet, np, QUADS, GLModel.DYNAMIC);
    
    // Updating the vertices to their initial positions.
    glmArbol.beginUpdateVertices();
    glmArbol.updateVertex(0, 0, 0, 0);
    glmArbol.updateVertex(1, ancho, 0, 0);
    glmArbol.updateVertex(2, ancho, alto, 0);
    glmArbol.updateVertex(3, 0, alto, 0);    
    glmArbol.endUpdateVertices();
    
    // Enabling the use of texturing...
    glmArbol.initTextures(1);
    // ... and loading and setting texture for this model.
    gltTextura = new GLTexture(applet, sTextura);    
    glmArbol.setTexture(0, gltTextura);
     
    // Setting the texture coordinates.
    glmArbol.beginUpdateTexCoords(0);
    glmArbol.updateTexCoord(0, 0, 0);
    glmArbol.updateTexCoord(1, 1, 0);    
    glmArbol.updateTexCoord(2, 1, 1);
    glmArbol.updateTexCoord(3, 0, 1);
    glmArbol.endUpdateTexCoords();
  }
  
  void display(float speedx)
  {
    GLGraphics renderer = (GLGraphics)g;
    renderer.beginGL();
    translate(0, 0, 0);
    
    pushMatrix();
      translate(x + speedx, y, 0);
      rectMode(CENTER);
      renderer.model(glmArbol);
    popMatrix();
    
    renderer.endGL();
  }
}

