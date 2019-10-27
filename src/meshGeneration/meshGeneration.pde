// I started to develop this code based on Daniel Shiffman's code (http://shiffman.net/p5/kinect/)

import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import java.util.*;

// Kinect Library object
Kinect kinect;

// Angle for rotation
float a = 0;

// We'll use a lookup table so that we don't have to repeat the math over and over
float[] depthLookUp = new float[2048];
Vector<PVector> points = new Vector<PVector>();
Vector<PVector> lastPoints = new Vector<PVector>();

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
}

void draw() {
   updatePoints();
   
  // Translate and rotate*/
  translate(width/2-sin(a)*100, height/2, 300-120*cos(a));
  rotateY(a);
  background(0);
  // Print points
  showPoints(points,1,1,1);
  showIndividual(points, genes[0], 0, 1, 0);
  // Rotate
  a += 0.01f;
}
