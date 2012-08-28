class Cielo extends Entidad {
  int cantidadNubes;
  
  private Nube[] nubes;
  private String sTextura;
  private GLModel glmNube;
  private GLTexture gltTextura;
  
  int np;
  
  Cielo(PApplet applet, String _sTextura, Entidad[] tiposNube, int cantidad, int _np, float _x, float _y, float _anchoc, float _altoc)
  {
    super(_x, _y, _anchoc, _altoc);
    cantidadNubes = cantidad;
    np = _np < 1 ? 1 : _np;
    sTextura = _sTextura;
    
    int ANCHO_REAL = round(np * ancho);
    
    crearCuerpoGL(applet, ANCHO_REAL);
    
    generadorNubes(applet, tiposNube, ANCHO_REAL);
  }
  
  void generadorNubes(PApplet applet, Entidad[] tiposNube, int rep)
  {
    int tipoNube, cantidadTipos = tiposNube.length;
    float pos_x, pos_y;
    nubes = new Nube[cantidadNubes];
    for (int i=0; i< cantidadNubes; i++)
    {
      pos_x = rep - random(rep);
      pos_y = (height - alto) - random(alto);
      
      tipoNube = round(random(cantidadTipos - 1));
      
      String path = tiposNube[tipoNube].path;
      float _ancho = tiposNube[tipoNube].ancho;
      float _alto = tiposNube[tipoNube].alto;
      
      nubes[i] = new Nube(applet, path, pos_x, pos_y, _ancho, _alto);
    }
  }
  
  private void crearCuerpoGL(PApplet applet, int _ancho) {
    try {
      glmNube = new GLModel(applet, np, QUADS, GLModel.STATIC);
      
      // Updating the vertices to their initial positions.
      glmNube.beginUpdateVertices();
      glmNube.updateVertex(0, 0, 0, 0);
      glmNube.updateVertex(1, _ancho, 0, 0);
      glmNube.updateVertex(2, _ancho, height, 0);
      glmNube.updateVertex(3, 0, height, 0);    
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
    } catch(Exception e) {
      println(e);
    }
  }
  
  void display(float speedx)
  {
    try {
      GLGraphics renderer = (GLGraphics)g;
      renderer.beginGL(); 
  
      renderer.model(glmNube);
    
      for (int i = 0; i < cantidadNubes; i++)
        nubes[i].display(renderer, speedx);
      
      renderer.endGL();
    } catch(Exception e) {
      println(e);
    }
  }
}
