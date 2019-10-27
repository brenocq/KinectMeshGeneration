import java.util.*;

int sizePopulation = 10;
int maxGeneration = 50;

int currPopulation = 0;

float[][] genes = new float [sizePopulation][6];
// Gene: translation (x,y,z) + rotation (x,y,z)

void initiatePopulation() {
  for (int i=0; i<sizePopulation; i++) {
    for (int j=0; j<3; j++) {
      genes[i][j] = (float)Math.random()*100-50.0f;// From -50 to 50
    }

    for (int j=3; j<6; j++) {
      genes[i][j] = (float)Math.random()*2*3.14f;// From 0 to 2pi
    }
  }
  System.out.printf("Population %d:\n", currPopulation);
  for (int i=0; i<sizePopulation; i++) {
    System.out.printf("\tGene %d: ", i);
    System.out.printf("(%2.2f,%2.2f,%2.2f) (%2.2f,%2.2f,%2.2f)\n", genes[i][0], genes[i][1], genes[i][2], genes[i][3], genes[i][4], genes[i][5]);
  }
}
