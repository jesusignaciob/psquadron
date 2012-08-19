class Arbol {
  float x;
  float y;
  PImage imagenArbol;
  
  Arbol(PImage imagen, float pos_x, float pos_y) {
    imagenArbol = imagen;
    x = pos_x;
    y = pos_y;
  }
  
  void display(float speedx) {
    image(imagenArbol, x + speedx, y);
  }
}
