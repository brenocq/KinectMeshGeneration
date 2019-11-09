import java.util.*;

int sizePopulation = 50;
int maxGeneration = 60;
float dispersion = 0.01;// Define dispersion of first individuals

int currGeneration = 0;
int bestIndPop = 0;
float error = 1000;

float[][] genes = new float [sizePopulation][6];
float[] fitness = new float [sizePopulation];
// Gene: translation (x,y,z) + rotation (x,y,z)

void initiatePopulation() {
  currGeneration = 0;

  for (int i=0; i<sizePopulation; i++) {
    for (int j=0; j<3; j++) {
      genes[i][j] = ((float)Math.random()*1-0.5f)*dispersion;// From -0.5 to 0.5
    }
    for (int j=3; j<6; j++) {
      genes[i][j] = (float)Math.random()*2*3.14f*dispersion;// From 0 to 2pi
    }
  }
  /*System.out.printf("Population %d:\n", currGeneration);
  for (int i=0; i<sizePopulation; i++) {
    System.out.printf("\tGene %d: ", i);
    System.out.printf("(%2.2f,%2.2f,%2.2f) (%2.2f,%2.2f,%2.2f)\n", genes[i][0], genes[i][1], genes[i][2], genes[i][3], genes[i][4], genes[i][5]);
  }*/
}

void processPopulation() {
  //System.out.printf("Processing generation %d...\n", currGeneration);
  System.out.printf("[");
  for (int i=0; i<sizePopulation; i++) {
    if(i%5==0)
      System.out.printf("-");
    
    
    fitness[i]=0;
    
    // For each current point to add...
    for (int j=0; j<points.size(); j++) {
      //----- Calculate point j -----//

      PVector v = points.elementAt(j);
      
      float px=v.x;
      float py=v.y;
      float pz=v.z;
      
      float newX, newY, newZ;
      // Rotate X
      newX = px*(1);
      newY = py*cos(genes[i][3]) -pz*sin(genes[i][3]);
      newZ = py*sin(genes[i][3]) +pz*cos(genes[i][3]);
      // Rotate Y
      px = newX*cos(genes[i][4])  -newZ*sin(genes[i][4]);
      py = newY*(1);
      pz = -newX*sin(genes[i][4]) +newZ*cos(genes[i][4]);
      // Rotate Z
      newX = px*cos(genes[i][5]) -py*sin(genes[i][5]);
      newY = px*sin(genes[i][5]) +py*cos(genes[i][5]);
      newZ = pz*(1);
      
      newX=newX+genes[i][0];
      newY=newY+genes[i][1];
      newZ=newZ+genes[i][2];
      
      double minDistance = 10;

      // Check with points added
      
      int size = allPoints.size()>0?allPoints.size():points.size();
      
      for (int k=0; k<size; k++) {
        if (k==j)
          continue;
          
        PVector p = allPoints.size()>0?allPoints.elementAt(k):points.elementAt(k);

        double distance = sqrt((p.x-newX)*(p.x-newX) + (p.y-newY)*(p.y-newY) + (p.z-newZ)*(p.z-newZ));
        minDistance = minimum(minDistance, distance);
      }
      fitness[i]+=minDistance;
      /*if(minDistance<0.005){
        fitness[i]+=1;
      }else if(minDistance<0.01){
        fitness[i]+=0.2;
      }*/
    }
    //System.out.printf("\tFitness %d: %2.2f\n", i, fitness[i]);
  }
  System.out.printf("]\n");
}

void crossing() {
  System.out.printf("Finishing generation %d... ", currGeneration);
  // Crossing parameters
  float mutationRate = 0.1;
  float crossingNeu  = 0.5;// Crossing neutralization
  float mutationNeu  = 0.3;// Mutation neutralization
  
  
  int bestInd = 0;
  float bestIndFitness = fitness[0];

  for (int i=0; i<sizePopulation; i++) {
    if (fitness[i]<fitness[bestInd]) {
      bestInd = i;
      bestIndFitness = fitness[i];
    }
  }
  
  for (int i=0; i<sizePopulation; i++) {
    if(i==bestInd)
      continue;
    for(int j=0;j<6;j++){
      genes[i][j] = (crossingNeu)*genes[i][j] + (1-crossingNeu)*genes[bestInd][j];
      
      float mutation = (float)Math.random();
      if(mutation<=mutationRate){
        if(j<3)// Translation
          genes[i][j] = (mutationNeu)*genes[i][j] + (1-mutationNeu)*(genes[i][j] + ((float)Math.random()*1-0.5f)*dispersion);
        else// Rotation
          genes[i][j] = (mutationNeu)*genes[i][j] + (1-mutationNeu)*(genes[i][j] + ((float)Math.random()*6.28-3.14f)*dispersion);
      }
    }
  }
  error = bestIndFitness;
  bestIndPop = bestInd;
  System.out.printf("Best individual: %2.2f\n",fitness[bestInd]);
  
  // Add processed points to the vector
  if(currGeneration==maxGeneration || error<=0.5){
    for (int i=0; i<points.size(); i++) {
      PVector v = points.elementAt(i);
      
      float px=v.x;
      float py=v.y;
      float pz=v.z;
      
      float newX, newY, newZ;
      // Rotate X
      newX = px*(1);
      newY = py*cos(genes[bestInd][3]) -pz*sin(genes[bestInd][3]);
      newZ = py*sin(genes[bestInd][3]) +pz*cos(genes[bestInd][3]);
      // Rotate Y
      px = newX*cos(genes[bestInd][4])  -newZ*sin(genes[bestInd][4]);
      py = newY*(1);
      pz = -newX*sin(genes[bestInd][4]) +newZ*cos(genes[bestInd][4]);
      // Rotate Z
      newX = px*cos(genes[bestInd][5]) -py*sin(genes[bestInd][5]);
      newY = px*sin(genes[bestInd][5]) +py*cos(genes[bestInd][5]);
      newZ = pz*(1);
      
      newX=newX+genes[bestInd][0];
      newY=newY+genes[bestInd][1];
      newZ=newZ+genes[bestInd][2];
      
      PVector newPoint = new PVector();
      newPoint.x = newX;
      newPoint.y = newY;
      newPoint.z = newZ;
      allPoints.add(newPoint);
      currGeneration = maxGeneration+1;
    }
  }
}
