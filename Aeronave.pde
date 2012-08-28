static class Movimiento {
  static int ARRIBA = 0;
  static int DERECHA = 1;
  static int ABAJO = 2;
  static int IZQUIERDA = 3;
  static int QUIETO = 4;
}

class Aeronave extends Entidad {
  PImage[] aeronave;
  HashMap armas;
  int salud;
  int cambioDeSprite;
  int posy_ant;
  int estado;
  
  Aeronave(String[] _aeronave, float _x, float _y, float _ancho, float _alto) {
    super(_x, _y, _ancho, _alto);
    
    int longitud = _aeronave.length;
    aeronave = new PImage[longitud];
    
    for (int i = 0; i <  longitud; i++)
      aeronave[i] = loadImage(_aeronave[i]);
    
    armas = new HashMap();
    
    posy_ant = 0;
    cambioDeSprite = 7;
    estado = 0;
  }
  
  void anadirArma(Arma arma) {
    armas.put(arma.id, arma);
  }
  
  void eliminarArma(Arma arma) {
    armas.remove(arma.id);
  }
  
  void mover(int dir) {
    switch(dir) {
      case 0:
        if (y >= 5)
          y -= 5;
        break;
      case 2:
        if (y < 450)
          y += 5;
        if (posy_ant <= cambioDeSprite) {
          estado = 1;
          posy_ant ++;
        }
        else
          estado = 2;
        break;
      case 3:
        if (x < width - ancho)
          x += 5;
        break;
      case 1:
        if (x > 0)
          x -= 5;
        break;
      default:
        estado = 0;
        posy_ant = 0;
    }
  }
  
  void display(float dx) {
    image(aeronave[estado], x + dx, y); // aeronave
  }
}

