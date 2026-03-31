PShape Momie1() {
  momie1 = createShape(GROUP);
  momie1.scale(0.12);
  momie1.translate(-45, -150, -25);
  momie1.rotateZ(PI);

  momie1.addChild(construireCorpsBrule());
  momie1.addChild(construireTeteBrulee());
  momie1.addChild(creerBrasBrule(true));
  momie1.addChild(creerBrasBrule(false));
  momie1.addChild(creerOeil(true));
  momie1.addChild(creerOeil(false));

  return momie1;
}

PShape Momie2() {
  momie2 = createShape(GROUP);
  momie2.scale(0.15);
  momie2.translate(-45, -150, -25);
  momie2.rotateZ(PI);

  momie2.addChild(construireCorpsMoisi());
  momie2.addChild(construireTeteMoisie());
  momie2.addChild(creerBrasMoisi(true));
  momie2.addChild(creerBrasMoisi(false));
  momie2.addChild(creerOeil(true));
  momie2.addChild(creerOeil(false));

  return momie2;
}

// === MOMIE 1 : BRÛLÉE ===

PShape construireCorpsBrule() {
  PShape corps = createShape();
  corps.beginShape(QUAD_STRIP);
  corps.noStroke();

  for (int z = -650; z <= 450; z++) {
    float r = random(90, 120);
    float g = random(20, 30);
    float b = random(10, 20);
    corps.fill(r, g, b);

    float angle = z / 50.0 * TWO_PI;
    float n = random(3, 4);
    float base = random(20, 30);
    float radius = 200 + ((abs(z / (3.0 + n)) - 200) * 0.2) * cos(angle) - abs(z / (3.0 + n));
    float rayon = (radius - 50) / 1.5;
    corps.vertex(rayon * cos(angle), rayon * sin(angle), (z + base - 75) / 2.0);
    corps.vertex(rayon * cos(angle), rayon * sin(angle), (z + base) / 2.0);
  }

  corps.endShape();
  return corps;
}

PShape construireTeteBrulee() {
  PShape tete = createShape();
  tete.translate(2, 0, 300);
  tete.beginShape(QUAD_STRIP);
  tete.noStroke();

  for (int z = -300; z <= 300; z++) {
    float r = random(100, 130);
    float g = random(30, 50);
    float b = random(10, 20);
    tete.fill(r, g, b);

    float angle = z / 50.0 * TWO_PI;
    float base = random(20, 30);
    float n = random(3, 4);
    float radius = 200 + ((abs(z / (3.0 + n)) - 200) * 0.2) * cos(angle) - abs(z / (3.0 + n));
    float rayon = (radius - 50) / 1.5;
    tete.vertex(rayon * cos(angle), rayon * sin(angle), (z + base - 75) / 4.0);
    tete.vertex(rayon * cos(angle), rayon * sin(angle), (z + base) / 4.0);
  }

  tete.endShape();
  return tete;
}

PShape creerBrasBrule(boolean droit) {
  PShape bras = createShape();
  bras.beginShape(QUAD_STRIP);
  bras.noStroke();
  bras.translate(droit ? 30 : -50, 120, -185);
  bras.rotateX(HALF_PI);

  for (int z = -100; z <= 250; z++) {
    float r = random(100, 130);
    float g = random(30, 50);
    float b = random(10, 20);
    bras.fill(r, g, b);

    float angle = z / 50.0 * TWO_PI;
    float base = random(20, 30);
    float n = random(3, 4);
    float radius = 200 + ((abs(z / (3.0 + n)) - 200) * 0.2) * cos(angle) - abs(z / (3.0 + n));
    float rayon1 = (radius - 50) / 6.0;
    float rayon2 = (radius - 50) / 10.0;
    float h = (z + base) / 2.0;

    bras.vertex(rayon1 * cos(angle), rayon1 * sin(angle), h - 75);
    bras.vertex(rayon2 * cos(angle), rayon2 * sin(angle), h);
  }

  bras.endShape();
  return bras;
}

// === MOMIE 2 : MOISIE ===

PShape construireCorpsMoisi() {
  PShape corps = createShape();
  corps.beginShape(QUAD_STRIP);
  corps.noStroke();

  for (int z = -650; z <= 450; z++) {
    float r = random(100, 140);
    float g = random(160, 200);
    float b = random(80, 100);
    corps.fill(r, g, b);

    float angle = z / 50.0 * TWO_PI;
    float n = random(3, 4);
    float base = random(20, 30);
    float radius = 200 + ((abs(z / (3.0 + n)) - 200) * 0.2) * cos(angle) - abs(z / (3.0 + n));
    float rayon = (radius - 50) / 1.5;
    corps.vertex(rayon * cos(angle), rayon * sin(angle), (z + base - 75) / 2.0);
    corps.vertex(rayon * cos(angle), rayon * sin(angle), (z + base) / 2.0);
  }

  corps.endShape();
  return corps;
}

PShape construireTeteMoisie() {
  PShape tete = createShape();
  tete.translate(2, 0, 300);
  tete.beginShape(QUAD_STRIP);
  tete.noStroke();

  for (int z = -300; z <= 300; z++) {
    float r = random(110, 140);
    float g = random(180, 220);
    float b = random(90, 110);
    tete.fill(r, g, b);

    float angle = z / 50.0 * TWO_PI;
    float base = random(20, 30);
    float n = random(3, 4);
    float radius = 200 + ((abs(z / (3.0 + n)) - 200) * 0.2) * cos(angle) - abs(z / (3.0 + n));
    float rayon = (radius - 50) / 1.5;
    tete.vertex(rayon * cos(angle), rayon * sin(angle), (z + base - 75) / 4.0);
    tete.vertex(rayon * cos(angle), rayon * sin(angle), (z + base) / 4.0);
  }

  tete.endShape();
  return tete;
}

PShape creerBrasMoisi(boolean droit) {
  PShape bras = createShape();
  bras.beginShape(QUAD_STRIP);
  bras.noStroke();
  bras.translate(droit ? 30 : -50, 120, -185);
  bras.rotateX(HALF_PI);

  for (int z = -100; z <= 250; z++) {
    float r = random(90, 120);
    float g = random(170, 210);
    float b = random(100, 130);
    bras.fill(r, g, b);

    float angle = z / 50.0 * TWO_PI;
    float base = random(20, 30);
    float n = random(3, 4);
    float radius = 200 + ((abs(z / (3.0 + n)) - 200) * 0.2) * cos(angle) - abs(z / (3.0 + n));
    float rayon1 = (radius - 50) / 6.0;
    float rayon2 = (radius - 50) / 10.0;
    float h = (z + base) / 2.0;

    bras.vertex(rayon1 * cos(angle), rayon1 * sin(angle), h - 75);
    bras.vertex(rayon2 * cos(angle), rayon2 * sin(angle), h);
  }

  bras.endShape();
  return bras;
}
PShape creerOeil(boolean droit) {
  PShape oeil = createShape(GROUP);

  float x = droit ? -110 : -170;
  float z = droit ? -120 : -120;

  // Blanc de l'œil (noir ici pour l'effet film momie)
  PShape sclere = createShape(ELLIPSE, 125, 200, 25, 10);
  sclere.setFill(color(0));
  sclere.translate(x, 95, z);
  sclere.rotateX(HALF_PI);
  oeil.addChild(sclere);

  // Pupille rouge
  PShape pupille = createShape(ELLIPSE, 125, 200, 5, 5);
  pupille.setFill(color(255, 0, 0));
  pupille.translate(x, 95, z);
  pupille.rotateX(HALF_PI);
  oeil.addChild(pupille);

  return oeil;
}
