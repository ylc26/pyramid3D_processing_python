void creerPyramide() {
  pyramide.noTint();
  pyramide.noStroke();
  
  

  
  for (int h = 0; h <= 22; h++) {
    for (int i = 0; i < LAB_SIZE - h * 2; i++) {
  
      if (h == 9) {
        pyramide.textureMode(NORMAL);
        pyramide.tint(255); 
      }
  
      // ========== MUR ARRIÈRE ==========
      pyramide.vertex(i * wallW - wallW/2 + wallW * h, -wallH - wallH/2 + (LAB_SIZE + 2) * wallH - wallH * h, -50 + 100 * h, 0, (0.5/2.0/WALLD) * texture0.height);
      pyramide.vertex(i * wallW + wallW/2 + wallW * h, -wallH - wallH/2 + (LAB_SIZE + 2) * wallH - wallH * h, -50 + 100 * h, 1f/WALLD * texture_pyramide.width, (0.5/2.0/WALLD) * texture_pyramide.height);
      pyramide.vertex(i * wallW + wallH/2 + wallW * h, -wallH + wallH/2 + LAB_SIZE * wallH - wallH * h, 50 + 100 * h, 1f/WALLD * texture_pyramide.width, (0.5+1/2.0/WALLD) * texture_pyramide.height);
      pyramide.vertex(i * wallW - wallH/2 + wallW * h, -wallH + wallH/2 + LAB_SIZE * wallH - wallH * h, 50 + 100 * h, 0, (0.5+1/2.0/WALLD) * texture_pyramide.height);
  
      // ========== MUR DROIT ==========
      pyramide.vertex(-wallH - wallH/2 + wallH * h, i * wallW - wallW/2 + wallW * h, -50 + 100 * h, 0, (0.5/2.0/WALLD) * texture0.height);
      pyramide.vertex(-wallH - wallH/2 + wallH * h, i * wallW + wallW/2 + wallW * h, -50 + 100 * h, 1f/WALLD * texture_pyramide.width, (0.5/2.0/WALLD) * texture_pyramide.height);
      pyramide.vertex(-wallH + wallH/2 + wallH * h, i * wallW + wallW/2 + wallW * h, 50 + 100 * h, 1f/WALLD * texture_pyramide.width, (0.5+1/2.0/WALLD) * texture_pyramide.height);
      pyramide.vertex(-wallH + wallH/2 + wallH * h, i * wallW - wallW/2 + wallW * h, 50 + 100 * h, 0, (0.5+1/2.0/WALLD) * texture_pyramide.height);
  
      // ========== MUR GAUCHE ==========
      pyramide.vertex(-wallH - wallH/2 + (LAB_SIZE + 2) * wallH - wallH * h, i * wallW - wallW/2 + wallW * h, -50 + 100 * h, 0, (0.5/2.0/WALLD) * texture0.height);
      pyramide.vertex(-wallH - wallH/2 + (LAB_SIZE + 2) * wallH - wallH * h, i * wallW + wallW/2 + wallW * h, -50 + 100 * h, 1f/WALLD * texture_pyramide.width, (0.5/2.0/WALLD) * texture_pyramide.height);
      pyramide.vertex(-wallH + wallH/2 + LAB_SIZE * wallH - wallH * h, i * wallW + wallH/2 + wallW * h, 50 + 100 * h, 1f/WALLD * texture_pyramide.width, (0.5+1/2.0/WALLD) * texture_pyramide.height);
      pyramide.vertex(-wallH + wallH/2 + LAB_SIZE * wallH - wallH * h, i * wallW - wallH/2 + wallW * h, 50 + 100 * h, 0, (0.5+1/2.0/WALLD) * texture_pyramide.height);
  
      // Évite de dessiner le mur avant à gauche de l'entrée (porte principale)
     if (!(i == entreeX && h == 0)) {
  
      // ========== MUR AVANT ==========
       pyramide.vertex(i * wallW - wallW / 2 + wallW * h, -wallH - wallH / 2 + wallH * h, -50 + 100 * h,
                  0, (0.5 / 2.0 / WALLD) * texture0.height);
     pyramide.vertex(i * wallW + wallW / 2 + wallW * h, -wallH - wallH / 2 + wallH * h, -50 + 100 * h,
                  1f / WALLD * texture_pyramide.width, (0.5 / 2.0 / WALLD) * texture_pyramide.height);
    pyramide.vertex(i * wallW + wallH / 2 + wallW * h, -wallH + wallH / 2 + wallH * h, 50 + 100 * h,
                  1f / WALLD * texture_pyramide.width, (0.5 + 1 / 2.0 / WALLD) * texture_pyramide.height);
    pyramide.vertex(i * wallW - wallH / 2 + wallW * h, -wallH + wallH / 2 + wallH * h, 50 + 100 * h,
                  0, (0.5 + 1 / 2.0 / WALLD) * texture_pyramide.height);
    }    
  }
}
  
  
  pyramide.textureMode(IMAGE);
  for (int h = 0; h <= 10; h++){
        // Coin arrière droit (renforce l'angle entre les murs latéraux)
        // Le vertex forme une bande verticale inclinée entre base et sommet
        pyramide.vertex(-wallH-wallH/2 + wallW*h, -wallH+wallH/2 + (LAB_SIZE) * wallH  - wallH*h, -50+ 100*h, 0, (0.5/2.0/WALLD)*texture0.height);
        pyramide.vertex(-wallW+wallH/2 + wallW*h, -wallH+wallH/2 + (LAB_SIZE) * wallH  - wallH*h, 50+ 100*h, 1/(float)WALLD*texture_pyramide.width, (0.5+(1)/2.0/WALLD)*texture_pyramide.height);
        pyramide.vertex(-wallW+wallW/2 + wallW*h, -wallH-wallH/2 + (LAB_SIZE+2) * wallH  - wallH*h, -50+ 100*h, 1/(float)WALLD*texture_pyramide.width, (0.5/2.0/WALLD)*texture_pyramide.height);
        pyramide.vertex(-wallW+wallW/2 + wallW*h, -wallH-wallH/2 + (LAB_SIZE+2) * wallH  - wallH*h, -50+ 100*h, 1/(float)WALLD*texture_pyramide.width, (0.5/2.0/WALLD)*texture_pyramide.height);
        
        // Coin avant droit
        pyramide.vertex(-wallH+wallH/2 + wallH*h, -wallW-wallW/2 + wallW*h, -50 + 100*h, 0, (0.5/2.0/WALLD)*texture0.height);
        pyramide.vertex(-wallH+wallH/2 + wallH*h, -wallW+wallW/2 + wallW*h, 50 + 100*h, 1/(float)WALLD*texture_pyramide.width, (0.5+(1)/2.0/WALLD)*texture_pyramide.height);
        pyramide.vertex(-wallH-wallH/2 + wallH*h, -wallW+wallW/2 + wallW*h, -50 + 100*h, 1/(float)WALLD*texture_pyramide.width, (0.5/2.0/WALLD)*texture_pyramide.height);
        pyramide.vertex(-wallH-wallH/2 + wallH*h, -wallW+wallW/2 + wallW*h, -50 + 100*h, 1/(float)WALLD*texture_pyramide.width, (0.5/2.0/WALLD)*texture_pyramide.height);      
        
       // Coin avant gauche
        pyramide.vertex(-wallH-wallH/2 + (LAB_SIZE+1) * wallH - wallH*h, -wallW-wallW/2 + wallW*h, -50 + 100*h, 0, (0.5/2.0/WALLD)*texture0.height);
        pyramide.vertex(-wallH-wallH/2 + (LAB_SIZE+2) * wallH - wallH*h, -wallW+wallW/2 + wallW*h, -50 + 100*h, 1/(float)WALLD*texture_pyramide.width, (0.5/2.0/WALLD)*texture_pyramide.height);
        pyramide.vertex(-wallH+wallH/2 + (LAB_SIZE) * wallH - wallH*h, -wallW+wallH/2 + wallW*h, 50 + 100*h, 1/(float)WALLD*texture_pyramide.width, (0.5+(1)/2.0/WALLD)*texture_pyramide.height);
        pyramide.vertex(-wallH+wallH/2 + (LAB_SIZE) * wallH - wallH*h, -wallW+wallH/2 + wallW*h, 50 + 100*h, 1/(float)WALLD*texture_pyramide.width, (0.5+(1)/2.0/WALLD)*texture_pyramide.height);
        
       // Mur avant (invisible si positionné côté labyrinthe)
        pyramide.vertex(-wallH-wallH/2 + (LAB_SIZE+2) * wallH - wallH*h, -wallH+wallH/2 + (LAB_SIZE) * wallH  - wallH*h, -50+ 100*h, 0, (0.5/2.0/WALLD)*texture0.height);
        pyramide.vertex(-wallH-wallH/2 + (LAB_SIZE+1) * wallH - wallH*h, -wallH+wallH/2 + (LAB_SIZE) * wallH  - wallH*h, 50+ 100*h, 1/(float)WALLD*texture_pyramide.width, (0.5+(1)/2.0/WALLD)*texture_pyramide.height);
        pyramide.vertex(-wallH+wallH/2 + (LAB_SIZE) * wallH - wallH*h, -wallH-wallH/2 + (LAB_SIZE+2) * wallH  - wallH*h, -50+ 100*h, 1/(float)WALLD*texture_pyramide.width, (0.5/2.0/WALLD)*texture_pyramide.height);
        pyramide.vertex(-wallH+wallH/2 + (LAB_SIZE) * wallH - wallH*h, -wallH-wallH/2 + (LAB_SIZE+2) * wallH  - wallH*h, -50+ 100*h, 1/(float)WALLD*texture_pyramide.width, (0.5/2.0/WALLD)*texture_pyramide.height);
  } 

  pyramide.endShape();
}

void dessinerCoinsEntree(float wallW, float wallH, int entreeX) {
  pyramide.beginShape(QUADS);
  float z0 = -50;
  float z1 = 50;
  float h = 0;

  // Coin droit (à gauche de l’entrée quand on regarde la pyramide)
  pyramide.vertex((entreeX - 1) * wallW + wallW / 2, -wallH - wallH / 2, z0,
    1f / WALLD * texture_pyramide.width, (0.5f / 2.0f / WALLD) * texture_pyramide.height);
  pyramide.vertex((entreeX - 1) * wallW + wallW / 2, -wallH - wallH / 2, z0,
    1f / WALLD * texture_pyramide.width, (0.5f / 2.0f / WALLD) * texture_pyramide.height);
  pyramide.vertex((entreeX - 1) * wallW + wallH / 2, -wallH + wallH / 2, z0,
    1f / WALLD * texture_pyramide.width, (0.5f + 1f / 2.0f / WALLD) * texture_pyramide.height);
  pyramide.vertex(entreeX * wallW - wallH / 2, -wallH + wallH / 2, z1,
    0, (0.5f + 1f / 2.0f / WALLD) * texture_pyramide.height);

  // Coin gauche (à droite de l’entrée quand on regarde la pyramide)
  pyramide.vertex((entreeX + 1) * wallW - wallW / 2, -wallH - wallH / 2, z0,
    1f / WALLD * texture_pyramide.width, (0.5f / 2.0f / WALLD) * texture_pyramide.height);
  pyramide.vertex((entreeX + 1) * wallW - wallW / 2, -wallH - wallH / 2, z0,
    1f / WALLD * texture_pyramide.width, (0.5f / 2.0f / WALLD) * texture_pyramide.height);
  pyramide.vertex((entreeX + 1) * wallW - wallH / 2, -wallH + wallH / 2, z0,
    1f / WALLD * texture_pyramide.width, (0.5f + 1f / 2.0f / WALLD) * texture_pyramide.height);
  pyramide.vertex((entreeX + 1) * wallW - wallH / 2, -wallH + wallH / 2, z1,
    0, (0.5f + 1f / 2.0f / WALLD) * texture_pyramide.height);
    pyramide.endShape();
}
