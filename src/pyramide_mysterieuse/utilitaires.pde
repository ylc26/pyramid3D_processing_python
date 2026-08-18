// trésor
int tresorX = 13;
int tresorY = 7;
int niveauTresor = 2;

//void initialiserTresor() {
//  niveauTresor = int(random(5)); // Choisit un niveau aléatoire

//  do {
//    tresorX = int(random(1, LAB_SIZE - 1));
//    tresorY = int(random(1, LAB_SIZE - 1));
//  } while (labyrinthe[niveauTresor][tresorY][tresorX] != ' ');
//}
//

void initialiserTresor() {
  println("Trésor placé manuellement en (X: 13, Y: 7, Niveau: 2)");
}

void verifierTresor() {
  if (posX == tresorX && posY == tresorY && iNiveau == niveauTresor) {
    println("Tu as découvert le trésor doré !");
  }
}

boolean estTresor(int i, int j, int niveau) {
  return i == tresorX && j == tresorY && niveau == niveauTresor;
}



void genererEntreeAleatoire() {
  // L'entrée sera placée aléatoirement sur la première ligne (j == 0)
  do {
    entreeX = int(random(1, LAB_SIZE-1));
  } while (entreeX % 2 == 0); // on prend seulement des indices impairs
   entreeY = 0;
}

void drawCompass() {
  pushStyle();
  pushMatrix();

  hint(DISABLE_DEPTH_TEST);
  camera();
  noLights();
  ortho();

  // Position et taille
  float cx = 100;
  float cy = height - 100;
  float radius = 60;

  // Fond style pierre dorée
  fill(223, 175, 44, 200);
  stroke(84, 66, 35);
  strokeWeight(4);
  ellipse(cx, cy, radius * 2, radius * 2);

  // Cercle intérieur
  stroke(139, 101, 8);
  strokeWeight(1.5);
  ellipse(cx, cy, radius * 1.4, radius * 1.4);

   // Directions cardinales
  textAlign(CENTER, CENTER);
  textSize(12);
  fill(0);
  text("N", cx, cy - radius + 10);
  text("S", cx, cy + radius - 10);
  text("E", cx + radius - 10, cy);
  text("W", cx - radius + 10, cy);

  // Aiguille dorée façon obélisque
  pushMatrix();
  translate(cx, cy);
  float angle = atan2(dirY, dirX);
  rotate(angle - HALF_PI);
  fill(255, 215, 0);
  stroke(84, 66, 35);
  strokeWeight(1.5);
  beginShape();
  vertex(0, -radius + 20);
  vertex(6, 10);
  vertex(-6, 10);
  endShape(CLOSE);
  popMatrix();

  hint(ENABLE_DEPTH_TEST);
  popMatrix();
  popStyle();
}
