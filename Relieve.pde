class Relieve extends Entidad {
  Cordillera[] montanas;
  int cantidadCordilleras;
  
  Relieve(PImage[] tiposMontana, int cantidad, float _x, float _y, float _ancho, float _alto) {
    super(_x, _y, _ancho, _alto);
    
    cantidadCordilleras = cantidad;
    
    generadorArboles(tiposMontana);
  }
  
  void generadorArboles(PImage[] tiposMontana)
  {
    int tipoMontana, cantidadTipos = tiposMontana.length;
    float pos_x, pos_y;
    montanas = new Cordillera[cantidadCordilleras];
    
    float rep = 0;
    for (int i = 0; i < cantidadCordilleras; i++) {
      tipoMontana = round(random(cantidadTipos - 1));
      montanas[i] = new Cordillera(tiposMontana[tipoMontana], rep, y);
      
      rep += ancho;
    }
  }
  
  void display(float speedx)
  {
    pushMatrix();
      translate(speedx, 0);
      rectMode(CORNER);
      for (int i = 0; i < cantidadCordilleras; i++)
        montanas[i].display();
    popMatrix();
  }
}
