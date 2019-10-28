void showPoints(Vector<PVector> vec, float r, float g, float b){
  float factor = 200;
  for(int i=0; i<vec.size(); i++){
    PVector v = vec.elementAt(i);
    
    stroke(r*255, g*255, b*255);
    pushMatrix();
    translate(v.x*factor, v.y*factor, factor-v.z*factor);
    point(0, 0);
    popMatrix();
  }
}

void showIndividual(Vector<PVector> points, float[] gene, float r, float g, float b){
  float factor = 200;
  for(int i=0; i<points.size(); i++){
    PVector v = points.elementAt(i);
    stroke(r*255, g*255, b*255);
    pushMatrix();
    
    // Translate point
    float px = (v.x);
    float py = (v.y);
    float pz = (v.z);
    
    float newX, newY, newZ;
    // Rotate X
    newX = px*(1);
    newY = py*cos(gene[3]) -pz*sin(gene[3]);
    newZ = py*sin(gene[3]) +pz*cos(gene[3]);

    // Rotate Y
    px = newX*cos(gene[4])  -newZ*sin(gene[4]);
    py = newY*(1);
    pz = -newX*sin(gene[4]) +newZ*cos(gene[4]);
    
    // Rotate Z
    newX = px*cos(gene[5]) -py*sin(gene[5]);
    newY = px*sin(gene[5]) +py*cos(gene[5]);
    newZ = pz*(1);
    
    newX=newX+gene[0];
    newY=newY+gene[1];
    newZ=newZ+gene[2];
    
    point(newX*factor, newY*factor, factor-newZ*factor);
    popMatrix();
  }
}


void updatePoints(){
  points.clear();
  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();
  // We're just going to calculate and draw every 4th pixel (equivalent of 160x120)
  int skip = 7;
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

  float offsetZ = 0;
  for(int i=0;i<points.size();i++){
    offsetZ+=points.elementAt(i).z;
  }
  
  offsetZ=offsetZ/points.size();
  
  for(int i=0;i<points.size();i++){
    points.elementAt(i).z = points.elementAt(i).z+offsetZ;
  }
}

void cleanPoints(){
  for(int i=0; i<allPoints.size(); i++){
    PVector v = allPoints.elementAt(i);
    for(int j=i+1; j<allPoints.size(); j++){
        PVector u = allPoints.elementAt(j);
        
        float dist = sqrt((u.x-v.x)*(u.x-v.x) + (u.y-v.y)*(u.y-v.y) + (u.z-v.z)*(u.z-v.z));
        
        if(dist<0.005){
          allPoints.remove(j);
        }
    }
  }
  
}
