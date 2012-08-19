class Cielo extends Entidad {
  Nube[] nubes;
  int cantidadNubes;
  PImage horizonte;
  
  int np;
  
  Cielo(PImage h, PImage[] tiposNube, int cantidad, int _np, float _x, float _y, float _ancho, float _alto)
  {
    super(_x, _y, _ancho, _alto);
    cantidadNubes = cantidad;
    horizonte = h;
    np = _np < 1 ? 1 : _np;
    
    generadorNubes(tiposNube, round(np * ancho));
  }
  
  void generadorNubes(PImage[] tiposNube, int rep)
  {
    int tipoNube, cantidadTipos = tiposNube.length;
    float pos_x, pos_y;
    nubes = new Nube[cantidadNubes];
    for (int i=0; i< cantidadNubes; i++)
    {
      pos_x = rep - random(rep);
      pos_y = (height - alto) - random(alto);
      
      tipoNube = round(random(cantidadTipos - 1));
      nubes[i] = new Nube(tiposNube[tipoNube], pos_x, pos_y);
    }
  }
  
  void display(float speedx)
  {
    float rep = 0;
    for (int i = 0; i < np; i++) {
      image(horizonte, rep - 5, 0);
      rep += ancho;
    }
    
    pushMatrix();
      translate(speedx, 0);
      rectMode(CORNER);
      for (int i = 0; i < cantidadNubes; i++)
        nubes[i].display(0);
    popMatrix();
  }
}
