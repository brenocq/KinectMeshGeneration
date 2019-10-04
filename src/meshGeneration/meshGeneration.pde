import org.openkinect.processing.*;

Kinect kinect;
void setup(){
  size(512, 424, P3D);
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.activateDevice(0); 
}

void draw(){
  background(0);
  PImage img = kinect.getDepthImage();
  //image(img, 0,0);
  
  int[] depth = kinect.getRawDepth();
  
  int skip=5;
  stroke(255);
  strokeWeight(2);
  beginShape(POINTS);
  for(int x=0;x<img.width;x+=skip){
    for(int y=0;y<img.height;y+=skip){
      int index = x+y*img.width;
      int d  = depth[index];
      
      PVector point = depthToPointCloudPos(x,y,d);
      vertex(x,y,0);
    }
  }
  
  fill(255);
  text(frameRate, 50, 50);
}

PVector depthToPointCloudPos(int x, int y, float depthValue){
 PVector point = new PVector();
 point.z = depthValue;
 point.x = (x-CameraParams.cx)*point.z/CameraParams.fx;
 point.y = (y-CameraParams.cy)*point.z/CameraParams.fy;
 return point;
}
