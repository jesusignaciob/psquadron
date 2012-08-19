class Aeronave extends Entidad {
  PImage[] aeronave;
  HashMap armas;
  int salud;
  
  Aeronave(PImage[] _aeronave, float _x, float _y, float _ancho, float _alto) {
    super(_x, _y, _ancho, _alto);
    
    aeronave = _aeronave;
    armas = new HashMap();
  }
  
  Aeronave(PImage[] _aeronave, float _x, float _y) {
    super(_x, _y, _aeronave[0].width, _aeronave[0].height);
    
    aeronave = _aeronave;
  }
  
  void anadirArma(Arma arma) {
    armas.put(arma.id, arma);
  }
  
  void eliminarArma(Arma arma) {
    armas.remove(arma.id);
  }
}
