//Libreria para el manejo de la Fisica
import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

//Libreria para el manejo de OpenGL
import processing.opengl.*;
import codeanticode.glgraphics.*;
import javax.media.opengl.GL;

//Libreria para el manejo de las resoluciones
import fullscreen.*;

FullScreen fs;

GL gl;

float x, y; 
float posy_ant, cambioDeSprite, dx, speed;
PImage[] radardome, torre;

int cantidadArboles, cantidadNubes, cantidadCordilleras, np;

Entidad[] tiposNube, tiposMontana;

Aeronave nave = null;
Cielo cielo = null;
Suelo suelo = null;
Bosque bosque = null;
Relieve relieve = null;
Edificacion edifRadardome = null, edifTorre = null;

PBox2D box2d;

PImage spriteBomba;

Bomba bomba = null;
ArrayList<Bomba> bombas = null;

void setup() {
  size(1600, 662, GLConstants.GLGRAPHICS);
  
  PGraphicsOpenGL pgl = (PGraphicsOpenGL)g;
  gl = pgl.beginGL(); //begin opengl
  gl.setSwapInterval(1); //set vertical sync on
  pgl.endGL(); //end opengl
  
  // Create the fullscreen object
  //fs = new FullScreen(this); 
  
  // enter fullscreen mode
  //fs.enter(); 
  
  //Inicializacion del Motor de Fisica
  inicializarMotorDeFisica();
  
  //Inicializacion de variables
  inicializarVariables();
  
  agregarTodosSprites();
  
  // Create ArrayLists
  bombas = new ArrayList<Bomba>();
  
  suelo = new Suelo(this, "base_suelo.png", np, 0, 512, width, 150);
  
  relieve = new Relieve(this, tiposMontana, cantidadCordilleras, 0, 400);
  
  edifRadardome = new Edificacion(radardome, 900, 512, radardome[0].width, radardome[0].height, 0.5);
  
  edifTorre = new Edificacion(torre, 700, 512, torre[0].width, torre[0].height, 0.5);
  
  cielo = new Cielo(this, "base_cielo.png", tiposNube, cantidadNubes, np, 0, 0, width, 300);
  
  String[] tiposArboles = {"arbol1.png", "arbol2.png"};
  
  bosque = new Bosque(this, tiposArboles, cantidadArboles, 0, 0, 600, 100, 200, 205);
  
  String[] _aeronave = {"example.png", "example2.png", "example3.png"};
  nave = new Aeronave(_aeronave, x, y, 198, 54);
  
  bombas = new ArrayList<Bomba>();
  
  frameRate(60);
}

void draw() {
  strokeWeight(0);
 
  // We must always step through time!
  box2d.step();
 
  //para manejar el evento presionar mouse y que tipo de boton se presiono, boton derecho: sube la nave, boton izquierdo: baja la nave
  if (mousePressed) {
    if (mouseButton == LEFT)
      nave.mover(Movimiento.ARRIBA);
    else {
      nave.mover(Movimiento.ABAJO);
    }
  }
  
  cielo.display(-dx*0.2);
  
  relieve.display(0);
  suelo.display();
  
  if (keyPressed) {
    teclaPresionada();
  }
  
  nave.display(dx); //Aeronave
  
  bosque.display(-dx*0.4);
  
  
  if (edifTorre != null)
    edifTorre.display();
  
  /*if (edifRadardome.estaDestruido())
    edifRadardome.matarCuerpo();
  else*/
    edifRadardome.display();
  
  for (int i = 0; i < bombas.size(); i++) {
    Bomba b = (Bomba)bombas.get(i);
    
    b.display();
    
    if (b.estaDestruido()) {
      b.matarCuerpo();
      bombas.remove(i);
    }  
  }
  
  dx += speed/60;
  
  camera(width/2.0 + dx, height/2.0, (height/2.0) / tan(PI*60.0 / 360.0), width/2.0 + dx, height/2.0, 0, 0, 1, 0);
}

void teclaPresionada() {
  if (key == CODED) {
    if (keyCode == LEFT)
      nave.mover(Movimiento.DERECHA);
    else if (keyCode == RIGHT)
      nave.mover(Movimiento.IZQUIERDA);
  }
}

// Collision event functions!
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  println("o2: " + o2.getClass()); 
  if (o2.getClass() == Bomba.class) {
  
    Bomba b = (Bomba)o2;
  
    if (o1.getClass() == Edificacion.class) {
      Edificacion e = (Edificacion)o1;
      
      if (e.estaDestruido())
        e = null;
      else
        e.recibirDano(b.obtenerDano());
        
    }
      
    b.colocarDestruido();   
  }
  
  //Explosion explosion = new Explosion();
}

// Objects stop touching each other
void endContact(Contact cp) {
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == ALT) {  
      bomba = new Bomba(spriteBomba, 0, "Bomba 1", nave.x + dx + nave.ancho/2, nave.y + nave.alto, 1);
      bombas.add(bomba);
    }
  }
  if (key == 'q')
     if (edifTorre.estaDestruido())
      edifTorre = null;
    else
      edifTorre.recibirDano(1);
}

void mouseReleased() {
  nave.mover(Movimiento.QUIETO);
}

void inicializarVariables() {
  x = 0;
  y = height/2.0;
  posy_ant = 0;
  speed = 5;
  np = 4;
  cambioDeSprite = 7;
  cantidadArboles = 20;
  cantidadNubes = 20;
  cantidadCordilleras = 20;
}

void inicializarMotorDeFisica() {
  box2d = new PBox2D(this);	
  box2d.createWorld();
  
  // We are setting a custom gravity
  box2d.setGravity(0, -9.8);
  
  // Turn on collision listening!
  box2d.listenForCollisions();
}

void agregarTodosSprites() {
  tiposMontana = new Entidad[2];
  tiposMontana[0] = new Entidad(x, y, 702, 124, "montana.png");
  tiposMontana[1] = new Entidad(x, y, 702, 124, "montana2.png");
  
  tiposNube = new Entidad[3];
  tiposNube[0] = new Entidad(x, y, 119, 41, "nube1_v2.png");
  tiposNube[1] = new Entidad(x, y, 60, 21, "nube2_v2.png");
  tiposNube[2] = new Entidad(x, y, 199, 69, "nube3_v2.png");
  
  radardome = new PImage[3];
  radardome[0] = loadImage("radardome1.png");
  radardome[1] = loadImage("radardome2.png");
  radardome[2] = loadImage("radardome3.png");
  
  torre = new PImage[3];
  torre[0] = loadImage("enemy1_1.png");
  torre[1] = loadImage("enemy1_2.png");
  torre[2] = loadImage("enemy1_3.png");
  
  spriteBomba = loadImage("bomba.png");
}

