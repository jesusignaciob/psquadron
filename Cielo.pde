class Cielo {
  float x;
  float y;
  float ancho;
  float alto;
  Nube[] nubes;
  int cantidadNubes;
  PImage horizonte;
  
  Cielo(PImage h, PImage[] tiposNube, int cantidad, float x, float y, float px, float py)
  {
    cantidadNubes = cantidad;
    x = x;
    y = y;
    ancho = px;
    alto = py;
    horizonte = h;
    
    generadorNubes(tiposNube);
  }
  
  void generadorNubes(PImage[] tiposNube)
  {
    int tipoNube, cantidadtipos = tiposNube.length;
    float pos_x, pos_y;
    nubes = new Nube[cantidadNubes];
    for (int i=0; i< cantidadNubes; i++)
    {
      pos_x = width - random(ancho);
      pos_y = (height - alto) - random(alto);
      
      tipoNube = round(random(cantidadtipos - 1));
      nubes[i] = new Nube(tiposNube[tipoNube], pos_x, pos_y);
    }
  }
  
  void display()
  {
    image(horizonte, 0, 0);
    
    for (int i = 0; i < cantidadNubes; i++)
      nubes[i].display();
  }
}
