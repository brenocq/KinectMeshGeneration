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

void setup() {
  // Rendering in P3D
  size(800, 600, P3D);
  kinect = new Kinect(this);
  kinect.initDepth();

  // Lookup table for all possible depth values (0 - 2047)
  for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
}

void draw() {
  float factor = 400;
  float meanZ=0, meanX=0, meanY=0;

   updatePoints();
   
   for(int i=0; i<points.size(); i++){
     meanZ+=points.elementAt(i).z;
     meanX+=points.elementAt(i).x;
     meanY+=points.elementAt(i).y;
   }
   meanX/=points.size();
   meanY/=points.size();
   meanZ/=points.size();
   
  // Translate and rotate
  translate(width/2, height/2, -20);
  rotateY(a);
  background(0);
  // Print points
  for(int i=0; i<points.size(); i++){
    PVector v = points.elementAt(i);
    
    
    stroke(255);
    pushMatrix();
    translate(v.x*factor, v.y*factor, factor-v.z*factor - (factor-meanZ*factor));
    point(0, 0);
    popMatrix();
  }

  // Rotate
  a += 0.01f;
}

void updatePoints(){
    points.clear();
    // Get the raw depth as array of integers
    int[] depth = kinect.getRawDepth();
    // We're just going to calculate and draw every 4th pixel (equivalent of 160x120)
    int skip = 4;
    for (int x = 0; x < kinect.width; x += skip) {
    for (int y = 0; y < kinect.height; y += skip) {
      int offset = x + y*kinect.width;

      // Convert kinect data to world xyz coordinate
      int rawDepth = depth[offset];
      PVector v = depthToWorld(x, y, rawDepth);

      if(v.z<1.5 && v.z>0.1){
        points.add(v);
      }
    }
  }
}
