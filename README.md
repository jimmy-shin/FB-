-platform linuxfb:size=1000x300
-platform linuxfb:fb=/dev/fb0:size=1000x300
-plugin evdevmouse -plugin evdevkeyboard -plugin evdevtouch:/dev/input/event##:rotate=90
-plugin evdevmouse:/dev/input/mouse0

linuxdeployqt Glance -qmldir=/home/jimmyshin/Qt5.13.0/5.13.0/gcc_64/qml/ -extra-plugins=platforms/libqlinuxfb.so -verbose=3
linuxdeployqt Glance -qmldir=/home/jimmyshin/Qt5.13.0/5.10.0/gcc_64/qml/ -extra-plugins=platforms/libqlinuxfb.so,platforminputcontexts/libqtvirtualkeyboardplugin.so -verbose=3

====================== 도어 내부 UI ======================
cp ../SmartDoor/build/desktop/release/SmartDoor_Inside/SmartDoor_Inside ./
linuxdeployqt SmartDoor_Inside -qmldir=/home/jimmyshin/Qt5.13.0/5.13.0/gcc_64/qml/ -extra-plugins=platforms/libqlinuxfb.so,generic/libqevdevtouchplugin.so -verbose=3
rsync -avz ./* bacs@192.168.111.87:/home/bacs/CrucialTrak/SmartDoor_Inside/

====================== 도어 외부 UI ======================
cp ../../../../build/desktop/release/SmartDoor_Outside/SmartDoor_Outside ./
linuxdeployqt SmartDoor_Outside -qmldir=/home/jimmyshin/Qt5.13.0/5.13.0/gcc_64/qml/ -extra-plugins=platforms/libqlinuxfb.so,generic/libqevdevtouchplugin.so -verbose=3
rsync -avz ./* bacs@192.168.111.87:/home/bacs/CrucialTrak/SmartDoor_Outside/

~/withrobot/stop.sh
sudo killall BACSVerify Verify.sh

====================== Killall ======================
~/CrucialTrak/
sudo killall outUI.sh SmartDoor_Outside
sudo killall insideUI.sh SmartDoor_Inside

====================== root 권한으로 실행시 xcb 오류 뜨는 경우 ======================
export DISPLAY=:0.0
export XAUTHORITY=/home/bacs/.Xauthority

tar -zcvf release.tar.gz ../../../build/desktop/release/* 압축
tar -zxvf release.tar.gz 압축해제

tar -xvf (파일명).tar.xz 압축해제

binarycreator --offline-only -c config/config.xml -p packages GlanceSetup.run

ssh pi@10.10.106.137
pi/raspberry
root/raspberry

ssh tube@192.168.106.47 (Linaro x64 4.4.143)
tube/tube

ssh bacs@10.10.106.147
bacs/trak
root/odroid

tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc

../qt-everywhere-src-5.13.0/configure -opengl es2 -device linux-rasp-pi3-g++ -device-option CROSS_COMPILE=/home/jimmyshin/opt/qt5pi/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf- -sysroot ~/opt/qt5pi/sysroot -prefix /usr/local/qt5pi -opensource -confirm-license -skip qtscript -nomake examples -make libs -pkg-config -no-use-gold-linker -v

../qt-everywhere-src-5.13.0/configure -opengl es2 -device linux-rasp-pi3-g++ -device-option CROSS_COMPILE=/home/jimmyshin/opt/qt5pi/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf- -sysroot ~/opt/qt5pi/sysroot -no-gcc-sysroot -prefix /usr/local/qt5pi -opensource -confirm-license -skip qtscript -nomake examples -make libs -pkg-config -no-use-gold-linker -v

../qt-everywhere-src-5.13.0/configure -platform linux-g++-64 -opengl es2 -device linux-rasp-pi3-g++ -device-option CROSS_COMPILE=/home/jimmyshin/opt/qt5pi/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf- -sysroot ~/opt/qt5pi/sysroot -no-gcc-sysroot -prefix /usr/local/qt5pi -opensource -confirm-license -skip qtscript -nomake examples -make libs -pkg-config -no-use-gold-linker -v

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

../qt-everywhere-src-5.13.0/configure -device linux-rasp-pi3-g++ -device-option CROSS_COMPILE=/home/jimmyshin/opt/qt5pi/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf- -sysroot ~/opt/qt5pi/sysroot -prefix /usr/local/qt5pi -opensource -confirm-license -skip qtscript -nomake examples -make libs -pkg-config -no-use-gold-linker -v

../qt-everywhere-src-5.13.0/configure -opengl es2 -device linux-rasp-pi3-g++ -device-option CROSS_COMPILE=/home/jimmyshin/opt/qt5pi/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf- -opensource -confirm-license -optimized-qmake -reduce-exports -release -make libs -prefix /usr/local/qt5pi

../qt-everywhere-src-5.13.0/configure -no-opengl -device linux-rasp-pi3-g++ -device-option CROSS_COMPILE=/home/jimmyshin/opt/qt5pi/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf- -opensource -confirm-license -optimized-qmake -reduce-exports -release -make libs -prefix /usr/local/qt5pi
------ 우분투 라즈베리 성공, opengl 생략함. ------

 ../qt-everywhere-src-5.13.0/configure -release -opengl es2 -device linux-rasp-pi3-g++ -device-option CROSS_COMPILE=/home/jimmyshin/opt/qt5pi/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf- -sysroot /home/jimmyshin/opt/qt5pi/sysroot -opensource -confirm-license -make libs -prefix /usr/local/qt5pi -extprefix /home/jimmyshin/opt/qt5pi -hostprefix /home/jimmyshin/opt/qt5 -v

 ../qt-everywhere-src-5.13.0/configure -platform linux-g++-64 -release -opengl es2 -device linux-rasp-pi3-g++ -device-option CROSS_COMPILE=/home/jimmyshin/opt/qt5pi/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf- -sysroot /home/jimmyshin/opt/qt5pi/sysroot -opensource -confirm-license -make libs -prefix /usr/local/qt5pi -extprefix /home/jimmyshin/opt/qt5pi -hostprefix /home/jimmyshin/opt/qt5 -v

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

..\Src\configure -opensource -confirm-license -release -opengl es2 -device linux-rasp-pi3-g++ -device-option CROSS_COMPILE="C:\SysGCC\raspberry\bin\arm-linux-gnueabihf-" -prefix /usr/local/qt5pi -extprefix "C:\Qt\raspberry_pi" -hostprefix "C:\Qt\raspberry_pi" -nomake examples -nomake tests -no-use-gold-linker -qt-pcre -skip qtscript -skip qttools -skip qtserialbus

..\Src\configure -opensource -confirm-license -release -opengl es2 -device linux-rasp-pi3-g++ -device-option CROSS_COMPILE="C:\SysGCC\raspberry\bin\arm-linux-gnueabihf-" -sysroot C:/SysGCC/raspberry/arm-linux-gnueabihf/sysroot -prefix /usr/local/qt5pi -extprefix "C:\Qt\raspberry_pi" -hostprefix "C:\Qt\raspberry_pi" -nomake examples -nomake tests -no-use-gold-linker -qt-pcre -skip qtscript -skip qttools -skip qtserialbus
------ 윈도우10 성공, opengl 사용, 라즈베리파이 데스크톱모드 ------

..\Src\configure -opensource -confirm-license -release -no-opengl -device linux-rasp-pi3-g++ -device-option CROSS_COMPILE="C:\SysGCC\raspberry\bin\arm-linux-gnueabihf-" -sysroot C:/SysGCC/raspberry/arm-linux-gnueabihf/sysroot -prefix /usr/local/qt5pi -extprefix "C:\Qt\raspberry_pi" -hostprefix "C:\Qt\raspberry_pi" -nomake examples -nomake tests -no-use-gold-linker -qt-pcre -skip qtscript -skip qttools -skip qtserialbus

..\Src\configure -opensource -confirm-license -release -no-opengl -make libs -device linux-rasp-pi3-g++ -device-option CROSS_COMPILE="C:\SysGCC\raspberry\bin\arm-linux-gnueabihf-" -sysroot C:/SysGCC/raspberry/arm-linux-gnueabihf/sysroot -prefix /usr/local/qt5pi -extprefix "C:\Qt\raspberry_pi" -hostprefix "C:\Qt\raspberry_pi" -nomake examples -nomake tests -no-use-gold-linker -qt-pcre -skip qtscript -skip qttools -skip qtserialbus
------ 윈도우10 성공, opengl 생략함. ------

--- 리나로 from 윈도우10 ---
..\Src\configure -opensource -confirm-license -release -opengl es2 -device linux-aarch64-gnu-g++ -device-option CROSS_COMPILE="C:\SysGCC\linaro\aarch64-linux-gnu-" -sysroot C:/SysGCC/linaro/aarch64-linux-gnu/sysroot -prefix /usr/local/qt5linaro -extprefix "C:\Qt\linaro" -hostprefix "C:\Qt\linaro" -nomake examples -nomake tests -no-use-gold-linker -qt-pcre -skip qtscript -skip qttools -skip qtserialbus

--- Odroid from 우분투 ---
../../qt-everywhere-src-5.13.0/configure -opengl es2 -device linux-odroid-xu3-g++ -device-option CROSS_COMPILE=arm-linux-gnueabihf- -sysroot ~/opt/qt5pi/qtOdroidBuild/sysroot -prefix /usr/local/qt5Odroid -opensource -confirm-license -skip qtscript -nomake examples -make libs -pkg-config -no-use-gold-linker -v

../../qt-everywhere-src-5.13.0/configure -no-opengl -device linux-odroid-xu3-g++ -device-option CROSS_COMPILE=arm-linux-gnueabihf- -sysroot ~/opt/qt5odroid/sysroot -prefix /usr/local/qt5odroid -opensource -confirm-license -skip qtscript -nomake examples -make libs -pkg-config -no-use-gold-linker -v

--- Tube from 우분투 --- (-device 생략, xplatform 지정 -no-opengl)
../../qt-everywhere-src-5.13.0/configure -no-opengl -xplatform linux-arm-gnueabihf-g++ -device-option CROSS_COMPILE=arm-linux-gnueabihf- -sysroot /home/jimmyshin/opt/qt5pi/qtTube/sysroot -prefix /usr/local/qt5Tube -opensource -confirm-license -skip qtscript -nomake examples -make libs -pkg-config -no-use-gold-linker -v
// 성공 했었던거같음

../../qt-everywhere-src-5.13.0/configure -no-opengl -alsa -gstreamer -xplatform linux-arm-gnueabihf-g++ -device-option CROSS_COMPILE=arm-linux-gnueabihf- -sysroot /home/jimmyshin/opt/qt5pi/qtTube/sysroot -prefix /usr/local/qt5Tube -opensource -confirm-license -skip qtscript -nomake examples -make libs -pkg-config -no-use-gold-linker -v
// -alsa -gstreamer 넣어서 성공?

../../qt-everywhere-src-5.13.0/configure -no-opengl -xplatform linux-arm-gnueabihf-g++ -device-option CROSS_COMPILE=arm-linux-gnueabihf- -sysroot /home/jimmyshin/opt/qt5tube/sysroot -prefix /usr/local/qt5Tube -opensource -confirm-license -skip qtscript -nomake examples -make libs -pkg-config -no-use-gold-linker -v

--- Tube ---
../../qt-everywhere-src-5.13.0/configure -opengl es2 -device-option CROSS_COMPILE=arm-linux-gnueabihf- -sysroot /home/jimmyshin/opt/qt5tube/sysroot -prefix /usr/local/qt5tube -opensource -confirm-license -skip qtscript -nomake examples -make libs -pkg-config -no-use-gold-linker -v

../../qt-everywhere-src-5.13.0/configure -opengl es2 -device-option CROSS_COMPILE=arm-linux-gnueabihf- -prefix /usr/local/qt5tube -opensource -confirm-license -skip qtscript -nomake examples -make libs -pkg-config -no-use-gold-linker -v

../../qt-everywhere-src-5.13.0/configure -device-option CROSS_COMPILE=arm-linux-gnueabihf- -sysroot /home/jimmyshin/opt/qt5tube/sysroot -prefix /usr/local/qt5tube -opensource -confirm-license -skip qtscript -nomake examples -make libs -pkg-config -no-use-gold-linker -v
// 중간중간 수동으로 없다는 헤더파일 튜브, 우분투에서 찾아서 다시 rsync로 복사, -no-opengl 넣어서 하면 될것 같음.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// 글랜스 arm64 크로스컴파일
./configure -opensource -confirm-license -prefix /usr/local/Qt-5.13.0-arm -embedded arm -little-endian -no-pch -xplatform linux-aarch64-gnu-g++
make -j2 ARCH=aarch64 CROSS_COMPILE=/usr/bin/aarch64-linux-gnu-

./configure -opensource -confirm-license -prefix /usr/local/Qt-5.13.0-arm -little-endian -no-pch -xplatform linux-aarch64-gnu-g++
make -j2 ARCH=aarch64 CROSS_COMPILE=/usr/bin/aarch64-linux-gnu-

./configure -opensource -confirm-license -no-opengl -prefix /usr/local/Qt-5.13.0-arm -no-pch -xplatform linux-aarch64-gnu-g++
make -j2 ARCH=aarch64 CROSS_COMPILE=/usr/bin/aarch64-linux-gnu-

./configure -no-opengl -device-option CROSS_COMPILE=/usr/bin/aarch64-linux-gnu- -opensource -confirm-license -optimized-qmake -reduce-exports -release -make libs -prefix /usr/local/Qt-5.13.0-arm
./configure -xplatform linux-aarch64-gnu-g++ -device-option CROSS_COMPILE=/usr/bin/aarch64-linux-gnu- -opensource -confirm-license -optimized-qmake -reduce-exports -release -make libs -prefix /usr/local/Qt-5.13.0-arm
./configure -no-opengl -xplatform linux-aarch64-gnu-g++ -device-option CROSS_COMPILE=/usr/bin/aarch64-linux-gnu- -opensource -confirm-license -optimized-qmake -reduce-exports -release -make libs -prefix /usr/local/Qt-5.13.0-aarch64
// 성공, -no-opengl 해야 됨... ㅠㅠ, xcb 안깔림... qtgraphicaleffects 안깔림...
