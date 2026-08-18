void generationLabyrinthe(char laby[][][], int dimension, int niveau) {
  // Nombre de cases à creuser (uniquement les cases impaires)
  int todig = (dimension / 2) * (dimension / 2);

  // Position initiale du "fantôme creuseur"
  int gx = 1;
  int gy = 1;

  // Boucle jusqu'à avoir creusé toutes les cases nécessaires
  while (todig > 0) {
    int oldgx = gx;
    int oldgy = gy;

    // Choix aléatoire de la direction de déplacement (influencé par le niveau)
    int alea = floor(random(0, 4 + niveau * 2)); 
    if      (alea == 0 && gx > 1)           gx -= 2; // gauche
    else if (alea == 1 && gy > 1)           gy -= 2; // haut
    else if (alea == 2 && gx < dimension-2) gx += 2; // droite
    else if (alea == 3 && gy < dimension-2) gy += 2; // bas

    // Si on tombe sur une cellule encore non creusée
    if (labyrinthe[niveau][gy][gx] == '.') {
      todig--; // une cellule de moins à creuser
      laby[niveau][gy][gx] = ' '; // on creuse la cellule actuelle
      laby[niveau][(gy + oldgy) / 2][(gx + oldgx) / 2] = ' '; // et celle entre l'ancienne et la nouvelle position
    }
  }
}
