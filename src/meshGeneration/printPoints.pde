void showPoints(Vector<PVector> points, float r, float g, float b){
  float factor = 400;
  for(int i=0; i<points.size(); i++){
    PVector v = points.elementAt(i);
    
    stroke(r*255, g*255, b*255);
    pushMatrix();
    translate(v.x*factor, v.y*factor, factor-v.z*factor);
    point(0, 0);
    popMatrix();
  }
}

void showIndividual(Vector<PVector> points, float[] gene, float r, float g, float b){
  float factor = 400;
  for(int i=0; i<points.size(); i++){
    PVector v = points.elementAt(i);
    
    translate(width/2-sin(a)*100, height/2, 300-120*cos(a));
    
    stroke(r*255, g*255, b*255);
    pushMatrix();
    translate((v.x+gene[0])*factor, (v.y+gene[1])*factor, factor-(v.z+gene[2])*factor);
    rotateX(gene[3]);
    rotateY(gene[4]);
    rotateZ(gene[5]);
    point(0, 0);
    popMatrix();
  }
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
        lastPoints = points;
      }
    }
  }
}
