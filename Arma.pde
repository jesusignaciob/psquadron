class Arma extends Entidad {
  int id;
  String nombre;
  
  int dano;
  PImage sprite;
  
  //  Instead of any of the usual variables, we will store a reference to a Box2D Body
  Body body;
  
  Arma(int _id, String _nombre, float _x, float _y, int _ancho, int _alto, int _dano) {
    super(_x, _y, _ancho, _alto);
    id = _id;
    nombre = _nombre;
    posy_ant = 0;
    
    dano = _dano;
  }
  
  int obtenerDano() {
    return dano;
  }
  
  void display() {
    
  }
}

