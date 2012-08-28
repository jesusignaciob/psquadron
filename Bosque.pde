class Bosque extends Entidad {
  Arbol[] arboles;
  int cantidadArboles;
  
  Bosque(PApplet applet, String[] tiposArbol, int cantidad, float _x, float _y, float _anchob, float _altob, float _anchoa, float _altoa) {
    super(_x, _y, _anchob, _altob);
    
    cantidadArboles = cantidad;
    
    generadorArboles(applet, tiposArbol, _anchoa, _altoa);
  }
  
  void generadorArboles(PApplet applet, String[] tiposArbol, float _ancho, float _alto)
  {
    int tipoArbol, cantidadtipos = tiposArbol.length;
    float pos_x, pos_y;
    arboles = new Arbol[cantidadArboles];
    
    for (int i=0; i< cantidadArboles; i++)
    {
      pos_x = width - random(ancho);
      pos_y = (height - alto) - random(alto);
      
      tipoArbol = round(random(cantidadtipos - 1));
      arboles[i] = new Arbol(applet, tiposArbol[tipoArbol], pos_x, pos_y, _ancho, _alto);
    }
  }
  
  void display(float speedx)
  {
    for (int i = 0; i < cantidadArboles; i++)
      arboles[i].display(speedx);
  }
}

