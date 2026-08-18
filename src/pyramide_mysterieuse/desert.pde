void genererDesert(float wallW, float wallH, float hauteurBase, float amplitudeNoise, int colR, int colG, int colB) {
  desert.noStroke();
  desert.noTint();

  for (int h = -LAB_SIZE * 3; h <= LAB_SIZE * 3; h++) {
    for (int i = -LAB_SIZE * 3; i <= LAB_SIZE * 3; i++) {
      float z00 = hauteurBase + noise(h, i) * amplitudeNoise;
      float z10 = hauteurBase + noise(h, i + 1) * amplitudeNoise;
      float z11 = hauteurBase + noise(h + 1, i + 1) * amplitudeNoise;
      float z01 = hauteurBase + noise(h + 1, i) * amplitudeNoise;

      if ((i < 1 || i > LAB_SIZE - 1 || i > LAB_SIZE * 2) || (h < 1 || h > LAB_SIZE - 1 || h > LAB_SIZE * 2)) {
        desert.vertex(i * wallW - wallW / 2, h * wallH - wallH / 2, z00, 0, 0);
        desert.vertex(i * wallW + wallW / 2, h * wallH - wallH / 2, z10, 1, 0);
        desert.vertex(i * wallW + wallW / 2, h * wallH + wallH / 2, z11, 1, 1);
        desert.vertex(i * wallW - wallW / 2, h * wallH + wallH / 2, z01, 0, 1);
      }
    }
  }

  float[][] terrain = calculerDune(20, LAB_SIZE * 6 - 1, 50, 0.2, -100, 100);

  dune_est = creerDune(terrain, 3*LAB_SIZE*wallW, -3*LAB_SIZE*wallW, -50, 0, color(colR, colG, colB));
  dune_nord = creerDune(terrain, 2*LAB_SIZE*wallW, -4*LAB_SIZE*wallW + 1350, -50, -HALF_PI, color(colR, colG, colB));
  dune_ouest = creerDune(terrain, 3*LAB_SIZE*wallW - 1350, -3*LAB_SIZE*wallW, -50, PI, color(colR, colG, colB));
  dune_sud = creerDune(terrain, 3*LAB_SIZE*wallW - 200, -5*LAB_SIZE*wallW + 1350, -50, HALF_PI, color(colR, colG, colB));
}
float[][] calculerDune(int cols, int rows, int scl, float freq, float zMin, float zMax) {
  float[][] terrain = new float[cols][rows];
  float yoff = 0.1;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, zMin, zMax + 30 * x);
      xoff += freq;
    }
    yoff += freq;
  }
  return terrain;
}

PShape creerDune(float[][] terrain, float tx, float ty, float tz, float rotation, color c) {
  PShape dune = createShape();
  dune.beginShape(TRIANGLE_STRIP);
  dune.translate(tx, ty, tz);
  dune.rotate(rotation);
  dune.fill(c);
  dune.noStroke();

  int rows = terrain[0].length;
  int cols = terrain.length;
  int scl = 50;

  for (int y = 0; y < rows - 1; y++) {
    for (int x = 0; x < cols; x++) {
      dune.vertex(x * scl, y * scl, terrain[x][y]);
      dune.vertex(x * scl, (y + 1) * scl, terrain[x][y + 1]);
    }
  }
  dune.endShape();
  return dune;
}

 
