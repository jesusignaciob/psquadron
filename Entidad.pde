class Entidad {
  String path;
  float x;
  float y;
  float ancho;
  float alto;
  
  Entidad(float _x, float _y, float _ancho, float _alto) {
    x = _x;
    y = _y;
    ancho = _ancho;
    alto = _alto;
  }
  
  Entidad(float _x, float _y, float _ancho, float _alto, String _path) {
    x = _x;
    y = _y;
    ancho = _ancho;
    alto = _alto;
    path = _path;
  }
}

