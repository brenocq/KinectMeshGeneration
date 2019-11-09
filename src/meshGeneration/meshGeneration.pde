// I started to develop this code based on Daniel Shiffman's code (http://shiffman.net/p5/kinect/)

import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import java.util.*;

// Kinect Library object
Kinect kinect;

// Angle for rotation
float a = 0.01;

// We'll use a lookup table so that we don't have to repeat the math over and over
float[] depthLookUp = new float[2048];
Vector<PVector> points = new Vector<PVector>();
Vector<PVector> allPoints = new Vector<PVector>();

void setup() {
  // Rendering in P3D
  size(800, 600, P3D);
  kinect = new Kinect(this);
  kinect.initDepth();

  // Lookup table for all possible depth values (0 - 2047)
  for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
  initiatePopulation();
  updatePoints();
}

int numberScanners = 50;
int currScanNum = 0;

void draw() {
   
  // Translate and rotate*/
  translate(width/2, height/2, 300);
  rotateY(a);
  background(0);
  
  // Print all points
  if(currScanNum==0){
    updatePoints();
    showPoints(points,1,1,1);
  }else{
    showPoints(allPoints,1,1,1);
    showIndividual(points, genes[bestIndPop], 0, 1, 0);
  }
  
  // Red point center
  stroke(255, 0, 0);
  pushMatrix();
  point(0, 0, 0);//
  popMatrix();
  
  // Show all individuals
  /*for(int i=0;i<sizePopulation;i++){
    float r = int((i+1)%2);
    float g = int(((i+1)/2)%2);
    float b = int(((i+1)/4)%2);
    showIndividual(points, genes[i], r, g, b);
  }*/
  
  /*if(currScanNum<numberScanners && a==0){
    // Print best individual
    
    //initiatePopulation();
    updatePoints();
    while(currGeneration<=maxGeneration){
      processPopulation();
      crossing();
      
      currGeneration++;
    }
    cleanPoints();
    System.out.printf("Size points vector: %d\n",allPoints.size());
    currGeneration = 0;
    currScanNum++;
  }*/
  // Rotate
  //a += 0.01f;
  if(a > 3.14*2){
    a=0;
  }
}
