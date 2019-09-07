# KinectMeshGeneration
Object mesh generation with Kinect and OpenGL

## Building the lib
```
cd lib
git clone https://github.com/OpenKinect/libfreenect
cd libfreenect
mkdir build
cd build
cmake -L .. # -L lists all the project options
make
```

If an error occurs with the `make` command, add the following line to `lib/libfreenect/CMakeLists.txt` (I added it on line 41):
```
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}  -std=c++11")
```
