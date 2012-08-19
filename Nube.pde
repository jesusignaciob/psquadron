class Nube {
  float x;
  float y;
  PImage imagenNube;
  
  Nube(PImage imagen, float pos_x, float pos_y)
  {
    imagenNube = imagen;
    x = pos_x;
    y = pos_y;
  }
  
  void display(float speedx)
  {
    image(imagenNube, x + speedx, y);
  }
}
