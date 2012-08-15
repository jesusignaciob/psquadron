import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

float y, posy_ant, cambioDeSprite = 7, x;
PImage a, bg, piSuelo, montana, montana2;  // tipo de variable para guardar la imagen en memoria
PImage[] images, radardome, torre, tiposNube = null, tiposArbol = null;

int cantidadArboles = 20, cantidadNubes = 20;

Cielo cielo = null;
Suelo suelo = null;
Bosque bosque = null;
Edificacion edifRadardome = null, edifTorre = null;

PBox2D box2d;

PImage spriteBomba;

Bomba bomba = null;
ArrayList<Bomba> bombas = null;

void setup() {
  size(1600,662);
  smooth();
  
  //Inicializacion del Motor de Fisica
  box2d = new PBox2D(this);	
  box2d.createWorld();
  
  // We are setting a custom gravity
  box2d.setGravity(0, -9.8);
  
  // Turn on collision listening!
  box2d.listenForCollisions();
  
  //Inicializacion de variables
  x = 0;
  y = height/2.0;
  posy_ant = 0;
  
  // Create ArrayLists
  bombas = new ArrayList<Bomba>();
  
  images = new PImage[3];
  
  images[0] = loadImage("example.png");
  images[1] = loadImage("example2.png");
  images[2] = loadImage("example3.png");
  
  a = images[0];  // cargo la imagen desde una ubicacion a memoria
  bg = loadImage("base_cielo.png");
  
  piSuelo = loadImage("base_suelo.png");
  suelo = new Suelo(piSuelo, 0, 512, piSuelo.width, piSuelo.height);
  
  radardome = new PImage[3];
  radardome[0] = loadImage("radardome1.png");
  radardome[1] = loadImage("radardome2.png");
  radardome[2] = loadImage("radardome3.png");
  
  edifRadardome = new Edificacion(radardome, 900, 512, radardome[0].width, radardome[0].height, 0.5);
  
  torre = new PImage[3];
  torre[0] = loadImage("enemy1_1.png");
  torre[1] = loadImage("enemy1_2.png");
  torre[2] = loadImage("enemy1_3.png");
  
  edifTorre = new Edificacion(torre, 700, 512, torre[0].width, torre[0].height, 0.5);
  
  montana = loadImage("montana.png");
  montana2 = loadImage("montana2.png");
  
  tiposNube = new PImage[3];
  tiposNube[0] = loadImage("nube1_v2.png");
  tiposNube[1] = loadImage("nube2_v2.png");
  tiposNube[2] = loadImage("nube3_v2.png");
  
  cielo = new Cielo(bg, tiposNube, cantidadNubes, 0, 0, width, 300);
  
  tiposArbol = new PImage[2];
  tiposArbol[0] = loadImage("arbol1.png");
  tiposArbol[1] = loadImage("arbol2.png");
  
  bosque = new Bosque(tiposArbol, cantidadArboles, 0, 0, 600, 100);
  
  spriteBomba = loadImage("bomba.png");
  
  bombas = new ArrayList<Bomba>();
  
  frameRate(30);
}

void draw() {
  //Para crear el cielo
  background(1);
 
  strokeWeight(0);
 
  // We must always step through time!
  box2d.step();
 
  //para manejar el evento presionar mouse y que tipo de boton se presiono, boton derecho: sube la nave, boton izquierdo: baja la nave
  if (mousePressed) {
    if (mouseButton == LEFT)
      y -= 5;
    else {
      y += 5;
      if (posy_ant <= cambioDeSprite) {
        a = images[1];
        posy_ant ++;
      }
      else
        a = images[2];
    }
  }
  
  cielo.display();
  
  image(montana, 0, 400);
  image(montana, 700, 400);
  image(montana2, 1400, 400);
  
  suelo.display();
  
  //image(suelo, 0, 512); //suelo
  
  image(a, x, y); // aeronave
  
  if (keyPressed) {
    teclaPresionada();
  }
  
  bosque.display();
  
  if (edifTorre.estaDestruido())
    edifTorre.matarCuerpo();
  else
    edifTorre.display();
  
  if (edifRadardome.estaDestruido())
    edifRadardome.matarCuerpo();
  else
    edifRadardome.display();
      
  for (Bomba b: bombas) {
    b.display();
  }
}

void teclaPresionada() {
  if (key == CODED) {
    if (keyCode == LEFT)
      x -= 5;
    else if (keyCode == RIGHT)
      x += 5;
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
  
  if (o2.getClass() == Bomba.class && o1.getClass() == Edificacion.class) {
    Bomba b = (Bomba)o2;
    Edificacion e = (Edificacion)o1;
    e.recibirDano(b.obtenerDano());
  }
}

// Objects stop touching each other
void endContact(Contact cp) {
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == ALT) {  
      bomba = new Bomba(spriteBomba, 0, "Bomba 1", x + a.width/2, y + a.height, spriteBomba.width, spriteBomba.height, 1);
      bombas.add(bomba);
    }
  }
}

void mouseReleased() {
  a = images[0];
  posy_ant = 0;
}
