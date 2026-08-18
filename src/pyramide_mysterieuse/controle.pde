void keyPressed() {
  
  if (key == ' ') {
    if (posX == tresorX && posY == tresorY && iNiveau == niveauTresor) {
      println("Tu as trouvé le trésor ! Fin du jeu...");
      delay(200);
      exit();
    } else {
      println("Le trésor n'est pas ici!");
    }
  }
  
  //  TOURNE GAUCHE (Q)
  if (anim == 0 && (key == 'q' || key == 'Q')) {
    int prevX = dirX;
    dirX = dirY;
    dirY = -prevX;
    odirX = prevX;
    odirY = dirY;
    anim = 20;
    animT = false;
    animR = true;
  }

  //  TOURNE DROITE (D)
  if (anim == 0 && (key == 'd' || key == 'D')) {
    int prevX = dirX;
    dirX = -dirY;
    dirY = prevX;
    odirX = prevX;
    odirY = dirY;
    anim = 20;
    animT = false;
    animR = true;
  }
  
  //  RECULER (S)
  if (anim == 0 && (key == 's' || key == 'S')) {
    int bx = posX - dirX;
    int by = posY - dirY;

    if (permeable || (bx >= 0 && bx < LAB_SIZE && by >= 0 && by < LAB_SIZE && labyrinthe[iNiveau][by][bx] != '#')
        || ((bx < -1 || bx > LAB_SIZE || by < -1 || by > LAB_SIZE) || (bx == 1 || by == -2)) 
        && (bx < LAB_SIZE * 2 && bx > -LAB_SIZE && by > -LAB_SIZE && by < 2 * LAB_SIZE)) {
      posX = bx;
      posY = by;
    }
    println("Position actuelle → X:", posX, "Y:", posY, "Niveau:", iNiveau);
  }

  //  AVANCER (Z)
  if (anim == 0 && (key == 'z' || key == 'Z')) {
    boolean avancerOK = false;

    if (permeable) {
      avancerOK = true;
    } else {
      int nx = posX + dirX;
      int ny = posY + dirY;
      if (nx >= 0 && nx < LAB_SIZE && ny >= 0 && ny < LAB_SIZE && labyrinthe[iNiveau][ny][nx] != '#') {
        avancerOK = true;
      } else if ((nx < -1 || nx > LAB_SIZE || ny < -1 || ny > LAB_SIZE) || (nx == 1 || ny == -2)) {
        if (nx < LAB_SIZE * 2 && nx > -LAB_SIZE && ny > -LAB_SIZE && ny < 2 * LAB_SIZE) {
          avancerOK = true;
        }
      }
    }

    if (avancerOK) {
      posX += dirX;
      posY += dirY;
      anim = 20;
      animT = true;
      animR = false;
    }
    println("Position actuelle → X:", posX, "Y:", posY, "Niveau:", iNiveau);
  }

  // ️ MONTER (J)
  if (anim == 0 && (key == 'j' || key == 'J')) {
    if (iNiveau == 0 && posX == passageX01 && posY == passageY01) {
      iNiveau++;
    } else if (iNiveau == 1 && posX == passageX12 && posY == passageY12) {
      iNiveau++;
    } else if (iNiveau == 2 && posX == passageX23 && posY == passageY23) {
      iNiveau++;
    } else if (iNiveau == 3 && posX == passageX34 && posY == passageY34) {
      iNiveau++;
    } else {
      return;
    }
    dirZ++;
    momie1.translate(0, 0, 100);
    momie2.translate(0, 0, 100);
  }

  // DESCENDRE (K)
  if (anim == 0 && (key == 'k' || key == 'K')) {
    if (iNiveau == 1 && posX == passageX01 && posY == passageY01) {
      iNiveau--;
    } else if (iNiveau == 2 && posX == passageX12 && posY == passageY12) {
      iNiveau--;
    } else if (iNiveau == 3 && posX == passageX23 && posY == passageY23) {
      iNiveau--;
    } else if (iNiveau == 4 && posX == passageX34 && posY == passageY34) {
      iNiveau--;
    } else {
      return;
    }
    dirZ--;
    momie1.translate(0, 0, -100);
    momie2.translate(0, 0, -100);
  }

  // ️ TÉLÉPORTATION DEVANT PYRAMIDE (P)
  if (anim == 0 && (key == 'p' || key == 'P')) {
    posX = entreeX;
    posY = -1;
    iNiveau = 0;
    dirZ = 0;
    permeable = !permeable;
    println(" Porte Ouverte !");
  }

  if (anim == 0 && key == 'f') {
    permeable = !permeable;
    println(permeable ? "permeable activé !" : "permeable désactivé");
  }
}
