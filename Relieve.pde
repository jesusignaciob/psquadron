class Relieve extends Entidad {
  Cordillera[] montanas;
  int cantidadCordilleras;
  
  Relieve(PApplet applet, Entidad[] tiposMontana, int cantidad, float _x, float _y) {
    super(_x, _y, 0, 0);
    
    cantidadCordilleras = cantidad;
    
    generadorArboles(applet, tiposMontana);
  }
  
  void generadorArboles(PApplet applet, Entidad[] tiposMontana)
  {
    int tipoMontana, cantidadTipos = tiposMontana.length;
    montanas = new Cordillera[cantidadCordilleras];
    
    float rep = 0;
    for (int i = 0; i < cantidadCordilleras; i++) {
      tipoMontana = round(random(cantidadTipos - 1));
      
      String path = tiposMontana[tipoMontana].path;
      float _ancho = tiposMontana[tipoMontana].ancho;
      float _alto = tiposMontana[tipoMontana].alto;
      
      montanas[i] = new Cordillera(applet, path, rep, y, _ancho, _alto);
      
      rep += _ancho;
    }
  }
  
  void display(float speedx)
  { 
    GLGraphics renderer = (GLGraphics)g;
    renderer.beginGL();
    
    for (int i = 0; i < cantidadCordilleras; i++)
      montanas[i].display(renderer, speedx);
      
    renderer.endGL();
  }
}

