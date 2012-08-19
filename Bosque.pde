class Bosque extends Entidad {
  Arbol[] arboles;
  int cantidadArboles;
  
  Bosque(PImage[] tiposArbol, int cantidad, float _x, float _y, float _ancho, float _alto) {
    super(_x, _y, _ancho, _alto);
    
    cantidadArboles = cantidad;
    
    generadorArboles(tiposArbol);
  }
  
  void generadorArboles(PImage[] tiposArbol)
  {
    int tipoArbol, cantidadtipos = tiposArbol.length;
    float pos_x, pos_y;
    arboles = new Arbol[cantidadArboles];
    
    for (int i=0; i< cantidadArboles; i++)
    {
      pos_x = width - random(ancho);
      pos_y = (height - alto) - random(alto);
      
      tipoArbol = round(random(cantidadtipos - 1));
      arboles[i] = new Arbol(tiposArbol[tipoArbol], pos_x, pos_y);
    }
  }
  
  void display(float speedx)
  {
    pushMatrix();
      translate(speedx, 0);
      rectMode(CORNER);
      for (int i = 0; i < cantidadArboles; i++)
        arboles[i].display(0);
    popMatrix();
  }
}
