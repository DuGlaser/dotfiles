#/bin/bash
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd ccls
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release
sudo cmake --build Release --target install
cd ../
rm -rf ccls
