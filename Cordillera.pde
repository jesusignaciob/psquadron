class Cordillera {
  float x;
  float y;
  PImage imagenCordillera;
  
  Cordillera(PImage imagen, float pos_x, float pos_y) {
    imagenCordillera = imagen;
    x = pos_x;
    y = pos_y;
  }
  
  void display() {
    image(imagenCordillera, x, y);
  }
}
