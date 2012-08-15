class Explosion extends Entidad {
  float xspeed = 2.8;  // Speed of the shape
  
  PImage[] sprites;
  
  Explosion(PImage[] _sprites, float _x, float _y, float _ancho, float _alto) {
    super(_x, _y, _ancho, _alto);
    
    sprites = _sprites;
  }
}
