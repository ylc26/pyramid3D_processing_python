import ddf.minim.*;

Minim minim;
AudioPlayer ambiance;
//niveaux suivants
int passageX01, passageY01;
int passageX12, passageY12;
int passageX23, passageY23;
int passageX34, passageY34;

PShape pyramide;     // pyramide
PShape desert;        // desert

//Momie1 et 2
PShape momie1, momie2;

// entree pyramide aleatoire
int entreeX;
int entreeY;


// Position initiale du joueur 
int iposX = 10;
int iposY = -10;

// Position actuelle du joueur dans le labyrinthe 
int posX = iposX;
int posY = iposY;

//Position de la momie dans le labyrinthe (coordonnées en cases) 
int posXM = 1;
int posYM = 3;

//  Position de la momie dans le labyrinthe (coordonnées en cases) 
int posXM2 = 1;
int posYM2 = 3;

//Direction de la momie 
int dirMomie1 = 0;
int dirMomie2 =0;

// Direction actuelle du joueur (X, Y) et ancienne direction (utilisée pour les animations de rotation) 
int dirX = 0;
int dirY = 1;
int odirX = 0;
int odirY = 1;
//Ajout Z
int dirZ = 0;
//  Détail de la paroi du labyrinthe (utilisé pour lisser les murs avec des subdivisions) 
int WALLD = 1;
float wallW;
float wallH;

// Niveau temp reel
int iNiveau;

// Variables d'animation (temps, type d'animation) 
int anim = 0;
boolean animT = false;      // Animation translation
boolean animR = false;      // Animation  rotation

boolean permeable = false;    // Mode permeable activé ?
boolean animB = false; // Animation reculer

// Indicateur si on est dans le labyrinthe ou à l'extérieur 
boolean inLab = true;

// Taille du labyrinthe 
int LAB_SIZE = 21;

//  Labyrinthe à 3 dimensions (niveau, lignes, colonnes) 
char labyrinthe[][][];

// === Indicateurs des ouvertures (couloirs) pour chaque case et chaque niveau ===
// sides[niveau][ligne][colonne][direction(0=haut,1=droite,2=bas,3=gauche)]
char sides[][][][];

//  Formes PShape pour les différents éléments de la scène 
PShape laby0;        // Labyrinthe courant
PShape ceiling0;     // Plafond niveau "intérieur"
PShape ceiling1;     // Plafond niveau "extérieur"

// Formes PShape pour les 4 grandes dunes autour de la pyramide 
PShape dune_nord;
PShape dune_sud;
PShape dune_ouest;
PShape dune_est;

// Textures utilisées dans le projet 
PImage texture0;         // Texture des murs intérieurs
PImage texture_pyramide; // Texture de l'extérieur de la pyramide
PImage sable;     // Texture du sable du désert

void setup() {
  
  minim = new Minim(this);
  ambiance = minim.loadFile("pyramide_ambiance.mp3", 2048);
  ambiance.loop();
  // Configuration de l'affichage
  pixelDensity(2); // Optimisation pour les écrans haute densité
  randomSeed(13);
  //randomSeed(26);
  
  // Chargement des textures
  texture0 = loadImage("stone.jpg");         // Texture pour l'intérieur du labyrinthe
  texture_pyramide = loadImage("facade.jpg"); // Texture extérieure pour la pyramide
  sable = loadImage("desert.jpg");         // Texture pour le sol du désert

  // Définition de la taille de la fenêtre et du rendu 3D
  size(1000, 1000, P3D);

  // Initialisation des labyrinthes pour 2 niveaux
  labyrinthe = new char[5][LAB_SIZE][LAB_SIZE];
  sides = new char[5][LAB_SIZE][LAB_SIZE][4]; // Marqueurs de directions de couloir

  // Construction initiale de la structure du labyrinthe : murs (#) et cellules creusables (.)
  for (int niv = 0; niv < 5; niv++) {
    for (int j = 0; j < LAB_SIZE; j++) {
      for (int i = 0; i < LAB_SIZE; i++) {
        sides[niv][j][i][0] = 0;
        sides[niv][j][i][1] = 0;
        sides[niv][j][i][2] = 0;
        sides[niv][j][i][3] = 0;

        if (j % 2 == 1 && i % 2 == 1) {
          labyrinthe[niv][j][i] = '.';
        } else {
          labyrinthe[niv][j][i] = '#';
        }
      }
    }
  }

   for (int i = 0; i < 5; i++) {
    int tailleLocale = LAB_SIZE-2*i;
  
    if (i == 3) {
      tailleLocale = tailleLocale - 2;
    } else if (i == 4) {
      tailleLocale = tailleLocale - 4;
    }
  
    generationLabyrinthe(labyrinthe, tailleLocale, i);
  }

  int marge0 = 0;
  int marge1 = 1;
  int marge2 = 2;
  int marge3 = 3;
  int marge4 = 4;
  
  // Niveau 0 -> 1
  do {
    passageX01 = int(random(1 + marge0, LAB_SIZE - 1 - marge0));
    passageY01 = int(random(1 + marge0, LAB_SIZE - 1 - marge0));
  } while (labyrinthe[0][passageY01][passageX01] != ' ' || labyrinthe[1][passageY01][passageX01] != ' ');
  
  // Niveau 1 -> 2
  do {
    passageX12 = int(random(1 + marge1, LAB_SIZE - 1 - marge1));
    passageY12 = int(random(1 + marge1, LAB_SIZE - 1 - marge1));
  } while (labyrinthe[1][passageY12][passageX12] != ' ' || labyrinthe[2][passageY12][passageX12] != ' ');
  
  // Niveau 2 -> 3
  do {
    passageX23 = int(random(1 + marge2, LAB_SIZE - 1 - marge2));
    passageY23 = int(random(1 + marge2, LAB_SIZE - 1 - marge2));
  } while (labyrinthe[2][passageY23][passageX23] != ' ' || labyrinthe[3][passageY23][passageX23] != ' ');
  
  // Niveau 3 -> 4
  do {
    passageX34 = int(random(1 + marge3, LAB_SIZE - 1 - marge3));
    passageY34 = int(random(1 + marge3, LAB_SIZE - 1 - marge3));
  } while (labyrinthe[3][passageY34][passageX34] != ' ' || labyrinthe[4][passageY34][passageX34] != ' ');


  initialiserTresor();
  genererEntreeAleatoire(); // met à jour entreeX et entreeY

  labyrinthe[0][entreeY][entreeX] = ' ';
  iposX = entreeX;
  iposY = entreeY - 1;
  // Initialisation du niveau actif
  iNiveau = 0;
  
  // Détection des extrémités de couloirs pour éclairages ou objets
  for (int niv = 0; niv < 5; niv++) {
    for (int j = 1; j < LAB_SIZE - 1 - 2 * niv; j++) {
      for (int i = 1; i < LAB_SIZE - 1 - 2 * niv; i++) {
        if (labyrinthe[niv][j][i] == ' ') {
          if (labyrinthe[niv][j - 1][i] == '#' && labyrinthe[niv][j + 1][i] == ' ' &&
              labyrinthe[niv][j][i - 1] == '#' && labyrinthe[niv][j][i + 1] == '#')
            sides[niv][j - 1][i][0] = 1;

          if (labyrinthe[niv][j - 1][i] == ' ' && labyrinthe[niv][j + 1][i] == '#' &&
              labyrinthe[niv][j][i - 1] == '#' && labyrinthe[niv][j][i + 1] == '#')
            sides[niv][j + 1][i][3] = 1;

          if (labyrinthe[niv][j - 1][i] == '#' && labyrinthe[niv][j + 1][i] == '#' &&
              labyrinthe[niv][j][i - 1] == ' ' && labyrinthe[niv][j][i + 1] == '#')
            sides[niv][j][i + 1][1] = 1;

          if (labyrinthe[niv][j - 1][i] == '#' && labyrinthe[niv][j + 1][i] == '#' &&
              labyrinthe[niv][j][i - 1] == '#' && labyrinthe[niv][j][i + 1] == ' ')
            sides[niv][j][i - 1][2] = 1;
        }
      }
    }
  }


  // Dimensions des murs du labyrinthe
  wallW = width / LAB_SIZE;
  wallH = height / LAB_SIZE;

  // Préparation des formes pour les toits, murs, pyramide et sol
  ceiling0 = createShape();
  ceiling1 = createShape();
  ceiling1.beginShape(QUADS);
  ceiling0.beginShape(QUADS);

  laby0 = createShape();
  laby0.beginShape(QUADS);
  laby0.texture(texture0);
  laby0.noStroke();

  pyramide = createShape();
  pyramide.beginShape(QUADS);
  pyramide.texture(texture_pyramide);
  pyramide.noStroke();

  
  laby0.noStroke();  // Désactive les contours des murs

for (int niv = 0; niv < 5; niv++) {
  for (int j = 0; j < LAB_SIZE; j++) {
    for (int i = 0; i < LAB_SIZE; i++) {

          // Ignorer les murs aux bords supprimés en cohérence avec la logique du labyrinthe
    int marge = niv;
    if (
      i < marge || j < marge || 
      i >= LAB_SIZE - marge || 
      j >= LAB_SIZE - marge
    ) continue;

      if (labyrinthe[niv][j][i] == '#') {
        laby0.fill(i * 25, j * 25, 255 - i * 10 + j * 10);  // Couleur du mur

        // Mur du haut (nord) si ouvert
        if (j == 0 || labyrinthe[niv][j - 1][i] == ' ') {
          laby0.normal(0, -1, 0);  // Normale vers le haut

          // Applique une teinte dorée si en haut du niveau
          if (j == 0) tint(223, 175, 44);

          if (niv == 1 && j == 0) {
            if (i == 0) continue;  // Ignore la première colonne

            for (int k = 0; k < WALLD; k++) {
              for (int l = -WALLD; l < WALLD; l++) {
                // Mur du bas pour le niveau supérieur
                laby0.vertex(i * wallW - wallW / 2 + (k + 0) * wallW / WALLD, j * wallH + wallH / 2, (l + 1) * 50 / WALLD + 100 * niv, (k + 0) / (float)WALLD * texture0.width, (0.5 + (l + 1) / 2.0 / WALLD) * texture0.height);
                laby0.vertex(i * wallW - wallW / 2 + (k + 1) * wallW / WALLD, j * wallH + wallH / 2, (l + 1) * 50 / WALLD + 100 * niv, (k + 1) / (float)WALLD * texture0.width, (0.5 + (l + 1) / 2.0 / WALLD) * texture0.height);
                laby0.vertex(i * wallW - wallW / 2 + (k + 1) * wallW / WALLD, j * wallH + wallH / 2, (l + 0) * 50 / WALLD + 100 * niv, (k + 1) / (float)WALLD * texture0.width, (0.5 + (l + 0) / 2.0 / WALLD) * texture0.height);
                laby0.vertex(i * wallW - wallW / 2 + (k + 0) * wallW / WALLD, j * wallH + wallH / 2, (l + 0) * 50 / WALLD + 100 * niv, (k + 0) / (float)WALLD * texture0.width, (0.5 + (l + 0) / 2.0 / WALLD) * texture0.height);
              }
            }

            laby0.noTint();
          } else {
            for (int k = 0; k < WALLD; k++) {
              for (int l = -WALLD; l < WALLD; l++) {
                // Mur du haut pour les autres cas
                laby0.vertex(i * wallW - wallW / 2 + (k + 0) * wallW / WALLD, j * wallH - wallH / 2, (l + 0) * 50 / WALLD + 100 * niv, k / (float)WALLD * texture0.width, (0.5 + l / 2.0 / WALLD) * texture0.height);
                laby0.vertex(i * wallW - wallW / 2 + (k + 1) * wallW / WALLD, j * wallH - wallH / 2, (l + 0) * 50 / WALLD + 100 * niv, (k + 1) / (float)WALLD * texture0.width, (0.5 + l / 2.0 / WALLD) * texture0.height);
                laby0.vertex(i * wallW - wallW / 2 + (k + 1) * wallW / WALLD, j * wallH - wallH / 2, (l + 1) * 50 / WALLD + 100 * niv, (k + 1) / (float)WALLD * texture0.width, (0.5 + (l + 1) / 2.0 / WALLD) * texture0.height);
                laby0.vertex(i * wallW - wallW / 2 + (k + 0) * wallW / WALLD, j * wallH - wallH / 2, (l + 1) * 50 / WALLD + 100 * niv, k / (float)WALLD * texture0.width, (0.5 + (l + 1) / 2.0 / WALLD) * texture0.height);
              }
            }

            laby0.noTint();
          }
        }
                  // Mur du bas (sud)
        if (j == LAB_SIZE - 1 || labyrinthe[niv][j + 1][i] == ' ') {
          if (j == LAB_SIZE - 1) laby0.tint(223, 175, 44);  // teinte dorée pour bord sud
          laby0.normal(0, 1, 0);
          for (int k = 0; k < WALLD; k++) {
            for (int l = -WALLD; l < WALLD; l++) {
              laby0.vertex(i * wallW - wallW / 2 + (k + 0) * wallW / WALLD, j * wallH + wallH / 2, (l + 1) * 50 / WALLD + 100 * niv,
                           (k + 0) / (float)WALLD * texture0.width, (0.5 + (l + 1) / 2.0 / WALLD) * texture0.height);
              laby0.vertex(i * wallW - wallW / 2 + (k + 1) * wallW / WALLD, j * wallH + wallH / 2, (l + 1) * 50 / WALLD + 100 * niv,
                           (k + 1) / (float)WALLD * texture0.width, (0.5 + (l + 1) / 2.0 / WALLD) * texture0.height);
              laby0.vertex(i * wallW - wallW / 2 + (k + 1) * wallW / WALLD, j * wallH + wallH / 2, (l + 0) * 50 / WALLD + 100 * niv,
                           (k + 1) / (float)WALLD * texture0.width, (0.5 + (l + 0) / 2.0 / WALLD) * texture0.height);
              laby0.vertex(i * wallW - wallW / 2 + (k + 0) * wallW / WALLD, j * wallH + wallH / 2, (l + 0) * 50 / WALLD + 100 * niv,
                           (k + 0) / (float)WALLD * texture0.width, (0.5 + (l + 0) / 2.0 / WALLD) * texture0.height);
            }
          }
          laby0.noTint();
        }
        
        // Mur de gauche (ouest)
        if (i == 0 || labyrinthe[niv][j][i - 1] == ' ') {
          if (niv == 1 && i == 0) {
            for (int k = 0; k < WALLD; k++) {
              for (int l = -WALLD; l < WALLD; l++) {
                laby0.vertex(i * wallW + wallW / 2, j * wallH - wallH / 2 + (k + 0) * wallW / WALLD, (l + 0) * 50 / WALLD + 100 * niv,
                             (k + 0) / (float)WALLD * texture0.width, (0.5 + (l + 0) / 2.0 / WALLD) * texture0.height);
                laby0.vertex(i * wallW + wallW / 2, j * wallH - wallH / 2 + (k + 1) * wallW / WALLD, (l + 0) * 50 / WALLD + 100 * niv,
                             (k + 1) / (float)WALLD * texture0.width, (0.5 + (l + 0) / 2.0 / WALLD) * texture0.height);
                laby0.vertex(i * wallW + wallW / 2, j * wallH - wallH / 2 + (k + 1) * wallW / WALLD, (l + 1) * 50 / WALLD + 100 * niv,
                             (k + 1) / (float)WALLD * texture0.width, (0.5 + (l + 1) / 2.0 / WALLD) * texture0.height);
                laby0.vertex(i * wallW + wallW / 2, j * wallH - wallH / 2 + (k + 0) * wallW / WALLD, (l + 1) * 50 / WALLD + 100 * niv,
                             (k + 0) / (float)WALLD * texture0.width, (0.5 + (l + 1) / 2.0 / WALLD) * texture0.height);
              }
            }
          } else {
            laby0.normal(-1, 0, 0);
            if (i == 0) laby0.tint(223, 175, 44);  // teinte dorée pour mur ouest
            for (int k = 0; k < WALLD; k++) {
              for (int l = -WALLD; l < WALLD; l++) {
                laby0.vertex(i * wallW - wallW / 2, j * wallH - wallH / 2 + (k + 0) * wallW / WALLD, (l + 1) * 50 / WALLD + 100 * niv,
                             (k + 0) / (float)WALLD * texture0.width, (0.5 + (l + 1) / 2.0 / WALLD) * texture0.height);
                laby0.vertex(i * wallW - wallW / 2, j * wallH - wallH / 2 + (k + 1) * wallW / WALLD, (l + 1) * 50 / WALLD + 100 * niv,
                             (k + 1) / (float)WALLD * texture0.width, (0.5 + (l + 1) / 2.0 / WALLD) * texture0.height);
                laby0.vertex(i * wallW - wallW / 2, j * wallH - wallH / 2 + (k + 1) * wallW / WALLD, (l + 0) * 50 / WALLD + 100 * niv,
                             (k + 1) / (float)WALLD * texture0.width, (0.5 + (l + 0) / 2.0 / WALLD) * texture0.height);
                laby0.vertex(i * wallW - wallW / 2, j * wallH - wallH / 2 + (k + 0) * wallW / WALLD, (l + 0) * 50 / WALLD + 100 * niv,
                             (k + 0) / (float)WALLD * texture0.width, (0.5 + (l + 0) / 2.0 / WALLD) * texture0.height);
              }
            }
            laby0.noTint();
          }
        }
        
        // Mur de droite (est)
        if (i == LAB_SIZE - 1 || labyrinthe[niv][j][i + 1] == ' ') {
          laby0.normal(1, 0, 0);
          if (i == LAB_SIZE - 1) laby0.tint(223, 175, 44);  // teinte dorée pour mur est
          for (int k = 0; k < WALLD; k++) {
            for (int l = -WALLD; l < WALLD; l++) {
              laby0.vertex(i * wallW + wallW / 2, j * wallH - wallH / 2 + (k + 0) * wallW / WALLD, (l + 0) * 50 / WALLD + 100 * niv,
                           (k + 0) / (float)WALLD * texture0.width, (0.5 + (l + 0) / 2.0 / WALLD) * texture0.height);
              laby0.vertex(i * wallW + wallW / 2, j * wallH - wallH / 2 + (k + 1) * wallW / WALLD, (l + 0) * 50 / WALLD + 100 * niv,
                           (k + 1) / (float)WALLD * texture0.width, (0.5 + (l + 0) / 2.0 / WALLD) * texture0.height);
              laby0.vertex(i * wallW + wallW / 2, j * wallH - wallH / 2 + (k + 1) * wallW / WALLD, (l + 1) * 50 / WALLD + 100 * niv,
                           (k + 1) / (float)WALLD * texture0.width, (0.5 + (l + 1) / 2.0 / WALLD) * texture0.height);
              laby0.vertex(i * wallW + wallW / 2, j * wallH - wallH / 2 + (k + 0) * wallW / WALLD, (l + 1) * 50 / WALLD + 100 * niv,
                           (k + 0) / (float)WALLD * texture0.width, (0.5 + (l + 1) / 2.0 / WALLD) * texture0.height);
            }
          }
          laby0.noTint();
        }
          // Plafond vert pour les cellules-mur
          ceiling1.fill(32, 255, 0);
          ceiling1.vertex(i*wallW-wallW/2, j*wallH-wallH/2, 50 + 100*niv);
          ceiling1.vertex(i*wallW+wallW/2, j*wallH-wallH/2, 50 + 100*niv);
          ceiling1.vertex(i*wallW+wallW/2, j*wallH+wallH/2, 50 + 100*niv);
          ceiling1.vertex(i*wallW-wallW/2, j*wallH+wallH/2, 50 + 100*niv);        
        }          else {
                  //  Cas spécial : PORTE D'ENTRÉE 
        if (j == entreeY && i == entreeX) {
          for (int k = 0; k < WALLD; k++) {
            for (int l = -WALLD; l < WALLD; l++) {
              laby0.tint(0, 245); // teinte bleue pour marquer la porte d'entrée
              laby0.vertex(i * wallW - wallW / 2 + (k + 0) * wallW / WALLD, j * wallH - wallH / 2, (l + 0) * 50 / WALLD,
                           k / (float) WALLD * texture0.width, (0.5 + l / 2.0 / WALLD) * texture0.height);
              laby0.vertex(i * wallW - wallW / 2 + (k + 1) * wallW / WALLD, j * wallH - wallH / 2, (l + 0) * 50 / WALLD,
                           (k + 1) / (float) WALLD * texture0.width, (0.5 + l / 2.0 / WALLD) * texture0.height);
              laby0.vertex(i * wallW - wallW / 2 + (k + 1) * wallW / WALLD, j * wallH - wallH / 2, (l + 1) * 50 / WALLD,
                           (k + 1) / (float) WALLD * texture0.width, (0.5 + (l + 1) / 2.0 / WALLD) * texture0.height);
              laby0.vertex(i * wallW - wallW / 2 + (k + 0) * wallW / WALLD, j * wallH - wallH / 2, (l + 1) * 50 / WALLD,
                           k / (float) WALLD * texture0.width, (0.5 + (l + 1) / 2.0 / WALLD) * texture0.height);
            }
          }
          laby0.noTint();
        }

                   // Cas spécial : SORTIE DU LABYRINTHE (sol + plafond) 
        if ((niv == 0 && j == passageY01 && i == passageX01) ||
            (niv == 1 && j == passageY12 && i == passageX12) ||
            (niv == 2 && j == passageY23 && i == passageX23) ||
            (niv == 3 && j == passageY34 && i == passageX34)) {
        
          // Sol du niveau courant (sortie)
          laby0.fill(192); 
          laby0.vertex(i * wallW - wallW / 2, j * wallH - wallH / 2, -50 + 100 * niv, 0, 0);
          laby0.vertex(i * wallW + wallW / 2, j * wallH - wallH / 2, -50 + 100 * niv, 0, 1);
          laby0.vertex(i * wallW + wallW / 2, j * wallH + wallH / 2, -50 + 100 * niv, 1, 1);
          laby0.vertex(i * wallW - wallW / 2, j * wallH + wallH / 2, -50 + 100 * niv, 1, 0);
        }
        
        // Cas spécial : PLAFOND de la case de sortie (au niveau supérieur) 
        if ((niv == 1 && j == passageY01 && i == passageX01) ||
            (niv == 2 && j == passageY12 && i == passageX12) ||
            (niv == 3 && j == passageY23 && i == passageX23) ||
            (niv == 4 && j == passageY34 && i == passageX34)) {
        
          ceiling0.fill(32); 
          ceiling0.vertex(i * wallW - wallW / 2, j * wallH - wallH / 2, 50 + 100 * niv);
          ceiling0.vertex(i * wallW + wallW / 2, j * wallH - wallH / 2, 50 + 100 * niv);
          ceiling0.vertex(i * wallW + wallW / 2, j * wallH + wallH / 2, 50 + 100 * niv);
          ceiling0.vertex(i * wallW - wallW / 2, j * wallH + wallH / 2, 50 + 100 * niv);
          ceiling0.noTint();
                 // Cas par défaut : sol et plafond des cellules couloir   
        } else {
            laby0.fill(230, 200, 170); // couleur sable chaud, plus lumineux
 // texture de sol
            laby0.vertex(i*wallW-wallW/2, j*wallH-wallH/2, -50 + 100*niv, 0, 0);
            laby0.vertex(i*wallW+wallW/2, j*wallH-wallH/2, -50 + 100*niv, 0, 1);
            laby0.vertex(i*wallW+wallW/2, j*wallH+wallH/2, -50 + 100*niv, 1, 1);
            laby0.vertex(i*wallW-wallW/2, j*wallH+wallH/2, -50 + 100*niv, 1, 0);
            
            ceiling0.fill(32); // plafond standard
            ceiling0.vertex(i*wallW-wallW/2, j*wallH-wallH/2, 50 + 100*niv);
            ceiling0.vertex(i*wallW+wallW/2, j*wallH-wallH/2, 50 + 100*niv);
            ceiling0.vertex(i*wallW+wallW/2, j*wallH+wallH/2, 50 + 100*niv);
            ceiling0.vertex(i*wallW-wallW/2, j*wallH+wallH/2, 50 + 100*niv);
            
          }
        }
      }
    }
   }
  
  laby0.endShape();       // Fin de la forme du labyrinthe
  ceiling0.endShape();    // Fin du plafond du niveau 0
  ceiling1.endShape();    // Fin du plafond du niveau 1
  
  creerPyramide();
  dessinerCoinsEntree(wallW, wallH, iposX);
  pyramide.endShape();    // Fin de la pyramide
  
  desert = createShape();
  desert.beginShape(QUADS);
  genererDesert(wallW, wallH, -50, 10, 235, 183, 105);
  desert.texture(sable);
  desert.endShape();
  
  // Finalisation de toutes les formes 3D : les appels à endShape() clôturent les constructions en cours
  dune_sud.endShape();     // Fin de la construction de la dune sud
  dune_ouest.endShape();   // Fin de la construction de la dune ouest
  dune_nord.endShape();    // Fin de la construction de la dune nord
  dune_est.endShape();     // Fin de la construction de la dune est

  momie1 = createShape(GROUP);
  Momie1();
  momie1.rotate(PI);     
  momie1.translate(width/LAB_SIZE * posXM*2, height/LAB_SIZE * posYM*2);
  dirMomie1=2;
  
  momie2 = Momie2();
  momie2.rotate(PI); // orientation initiale
  momie2.translate(width / LAB_SIZE * posXM2 * 2, height / LAB_SIZE * posYM2 * 2);

  
   
}


void draw() {
  // Définir la couleur de fond du ciel
  background(192);
  

  // Définir le niveau de détail des sphères pour améliorer les performances
  sphereDetail(6);

  // Réduire le compteur d'animation à chaque frame
  if (anim > 0) anim--;

  // Calcul des dimensions d'une case du labyrinthe
  float wallW = width / LAB_SIZE;
  float wallH = height / LAB_SIZE;

  // Définir la perspective et la caméra pour la vue initiale
  perspective();
  camera(width / 2.0, height / 2.0, (height / 2.0) / tan(PI * 30.0 / 180.0), 
         width / 2.0, height / 2.0, 0, 0, 1, 0);

  // Désactiver les lumières pour ce mode d'affichage
  noLights();
  stroke(0); // Activer les contours noirs
  
  // Mini-map claire avec des rectangles nets
  float cellSize = 5;
  int tailleLocale = LAB_SIZE-2*iNiveau;


  if (iNiveau == 3) {
    tailleLocale = tailleLocale - 2;
  } else if (iNiveau == 4) {
    tailleLocale = tailleLocale - 4;
  }
  
  for (int j = 0; j < tailleLocale; j++) {
    for (int i = 0; i < tailleLocale; i++) {
      if ((posX >= 0 && posX <= LAB_SIZE) && (posY >= -1 && posY <= LAB_SIZE)) {
        
          boolean isSortie = 
          (iNiveau == 0 && j == passageY01 && i == passageX01) ||
          (iNiveau == 1 && j == passageY12 && i == passageX12) ||
          (iNiveau == 2 && j == passageY23 && i == passageX23) ||
          (iNiveau == 3 && j == passageY34 && i == passageX34);
  
        boolean isMomie1 = (j == posYM && i == posXM);
        boolean isMomie2 = (j == posYM2 && i == posXM2);
        boolean isMur = labyrinthe[iNiveau][j][i] == '#';
  
        float x = 20 + i * cellSize;
        float y = 20 + j * cellSize;
  
        noStroke();
        if (isMomie1) {
          fill(150, 150, 50); // jaune
        } else if (estTresor(i, j, iNiveau)) {
          fill(223, 175, 44); // Or
        } else if (isMomie2) {
          fill(255, 0, 0); // rouge
        } else if (isSortie) {
          fill(230, 230, 250); // rose vif (Hot Pink)
        } else if (isMur) {
          fill(i * 10, j * 10, 255 - i * 5 + j * 5); // mur coloré
        } else {
          continue; // on n'affiche pas les cases vides
        }
  
        rect(x, y, cellSize, cellSize);
      }
    }
  }
  
  // Joueur
  if ((posX >= 0 && posX <= LAB_SIZE) && (posY >= -1 && posY <= LAB_SIZE)) {
    fill(0, 255, 0); // vert
    rect(20 + posX * cellSize, 20 + posY * cellSize, cellSize, cellSize);
  }



    


  // Activation des contours noirs
  stroke(0);
  
  // Caméra et perspective pour la vue 3D dans le labyrinthe
  if (inLab) {
    perspective(2 * PI / 3, float(width) / float(height), 1, 10000);
    
    // Animation de translation vers l'avant
    if (animT) {
      camera((posX - dirX * anim / 20.0) * wallW, (posY - dirY * anim / 20.0) * wallH, -15 + 2 * sin(anim * PI / 5.0) + 100 * dirZ,
             (posX - dirX * anim / 20.0 + dirX) * wallW, (posY - dirY * anim / 20.0 + dirY) * wallH, -15 + 4 * sin(anim * PI / 5.0) + 100 * dirZ, 
             0, 0, -1);
    }
    // Animation de rotation
    else if (animR) {
      camera(posX * wallW, posY * wallH, -15 + 100 * dirZ,
             (posX + (odirX * anim + dirX * (20 - anim)) / 20.0) * wallW, 
             (posY + (odirY * anim + dirY * (20 - anim)) / 20.0) * wallH, 
             -15 - 5 * sin(anim * PI / 20.0) + 100 * dirZ, 0, 0, -1);
    }
    // Caméra fixe sans animation
    else {
      camera(posX * wallW, posY * wallH, -15 + 100 * dirZ,
             (posX + dirX) * wallW, (posY + dirY) * wallH, -15 + 100 * dirZ, 
             0, 0, -1);
    }
  
      // Éclairage ponctuel autour du joueur
      if (posX >= 0 && posX < LAB_SIZE && posY >= 0 && posY + dirY < LAB_SIZE && dirZ <= 1) {
        lightFalloff(1.0, 0.02, 0.0001);
      }
      pointLight(255, 255, 255, posX * wallW, posY * wallH, 15);
    } else {
      // Éclairage global extérieur
      lightFalloff(0.0, 0.05, 0.0001);
      pointLight(255, 255, 255, width / 2, height / 2, 300 * LAB_SIZE);
    }
  
  // ESSAI : Affichage des sphères représentant les sorties du labyrinthe pour chaque niveau
  noStroke();
  for (int j = 0; j < LAB_SIZE; j++) {
    for (int i = 0; i < LAB_SIZE; i++) {
      pushMatrix();
      translate(i * wallW, j * wallH, 0);
  
      if (labyrinthe[iNiveau][j][i] == '#') {
        beginShape(QUADS);
  
        for (int d = 0; d < 4; d++) {
          if (sides[iNiveau][j][i][d] == 1) {
            pushMatrix();
  
            // Positionnement selon la direction
            switch(d) {
              case 0: translate(0, wallH / 2, 40); break;   // nord
              case 1: translate(-wallW / 2, 0, 40); break;  // est
              case 2: translate(0, wallH / 2, 40); break;   // ouest (identique à nord)
              case 3: translate(0, -wallH / 2, 40); break;  // sud
            }
  
            if (i == posX || j == posY) {
              fill(i * 25, j * 25, 255 - i * 10 + j * 10);
              sphere(5);
              spotLight(i * 25, j * 25, 255 - i * 10 + j * 10, 0, -15, 15, 0, 0, -1, PI / 4, 1);
            } else {
              fill(128);
              sphere(15);
            }
  
            popMatrix();
          }
        }
  
        endShape();
      }
  
      popMatrix();
    }
  }

  if (frameCount % 50 == 0) {
    int[] dx = {0, 1, 0, -1};  // haut, droite, bas, gauche
    int[] dy = {-1, 0, 1, 0};
    ArrayList<Integer> directions = new ArrayList<Integer>();
  
    for (int d = 0; d < 4; d++) {
      int nx = posXM + dx[d];
      int ny = posYM + dy[d];
      if (nx >= 0 && nx < LAB_SIZE && ny >= 0 && ny < LAB_SIZE && labyrinthe[iNiveau][ny][nx] != '#') {
        directions.add(d);
      }
    }
  
    if (directions.size() > 0) {
      int chosen = directions.get(int(random(directions.size())));
      posXM += dx[chosen];
      posYM += dy[chosen];
      momie1.translate(dx[chosen] * width / LAB_SIZE, dy[chosen] * height / LAB_SIZE);
      dirMomie1 = chosen;
    }
  }
  
  if (frameCount % 25 == 0) {
    int[] dx2 = {0, 1, 0, -1};
    int[] dy2 = {-1, 0, 1, 0};
    ArrayList<Integer> directions2 = new ArrayList<Integer>();
  
    for (int d = 0; d < 4; d++) {
      int nx2 = posXM2 + dx2[d];
      int ny2 = posYM2 + dy2[d];
      if (nx2 >= 0 && nx2 < LAB_SIZE && ny2 >= 0 && ny2 < LAB_SIZE && labyrinthe[iNiveau][ny2][nx2] != '#') {
        directions2.add(d);
      }
    }
  
    if (directions2.size() > 0) {
      int chosen2 = directions2.get(int(random(directions2.size())));
      posXM2 += dx2[chosen2];
      posYM2 += dy2[chosen2];
      momie2.translate(dx2[chosen2] * width / LAB_SIZE, dy2[chosen2] * height / LAB_SIZE);
      dirMomie2 = chosen2;
    }
  }

  //Affichage  
  shape(laby0, 0, 0);
  shape(pyramide, 0, 0);
  shape(desert, 0, 0);
  shape(dune_sud, 0, 0); 
  shape(dune_nord, 0, 0); 
  shape(dune_est, 0, 0);
  shape(dune_ouest, 0, 0); 
  shape(momie2, 0, 0);
  shape(momie1, 0, 0);
  // Affichage du plafond (en fonction de si on est dans le labyrinthe ou non)
  if (inLab)
    shape(ceiling0, 0, 0);
  else
    shape(ceiling1, 0, 0);
    
    drawCompass();
}

void stop() {
  ambiance.close();
  minim.stop();
  super.stop();
}
