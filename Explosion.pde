class Explosion extends Entidad {
  float speed;  // Speed of the shape
  
  int frame;
  
  PImage[] sprites;
  
  Explosion(PImage[] _sprites, float _speed, float _x, float _y, float _ancho, float _alto) {
    super(_x, _y, _ancho, _alto);
    
    speed = _speed;
    frame = 0;
    sprites = _sprites;
  }
  
  void display() {
    image(sprites[frame++], x, y);
  }
}
