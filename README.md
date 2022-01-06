-platform linuxfb:size=1000x300
-platform linuxfb:fb=/dev/fb0:size=1000x300
-plugin evdevmouse -plugin evdevkeyboard -plugin evdevtouch:/dev/input/event##:rotate=90
-plugin evdevmouse:/dev/input/mouse0

=========== 프레임버퍼 영상 네트워크 재생 ===========
ffmpeg -f fbdev -framerate 25 -i /dev/fb0 -c:v libx264 -preset ultrafast -tune zerolatency -maxrate 2000k -bufsize 4000k -vf "format=yuv420p" -g 50 -f rtp_mpegts "rtp://10.10.106.122:20001"
ffmpeg -f fbdev -framerate 25 -i /dev/fb0 -c:v libx264 -preset ultrafast -tune zerolatency -maxrate 2000k -bufsize 4000k -vf "format=yuv420p,hflip" -g 50 -f rtp_mpegts "rtp://10.10.106.122:20001"
ffmpeg -f fbdev -framerate 25 -i /dev/fb0 -c:v libx264 -preset ultrafast -tune zerolatency -maxrate 2000k -bufsize 4000k -vf "hflip" -g 50 -f rtp_mpegts "rtp://10.10.106.122:20001"
ffmpeg -f fbdev -framerate 25 -i /dev/fb0 -c:v libx264 -preset ultrafast -tune zerolatency -maxrate 2000k -bufsize 4000k -vf "format=yuv420p" -g 50 -f rtp_mpegts "rtp://10.10.106.103:20001" > /dev/null 2>&1
ffmpeg -f fbdev -framerate 25 -i /dev/fb0 -c:v libx264 -preset ultrafast -tune zerolatency -maxrate 2000k -bufsize 4000k -vf "format=yuv420p,hflip" -g 50 -f rtp_mpegts "rtp://10.10.106.103:20001" > /dev/null 2>&1
ffmpeg -f fbdev -framerate 25 -i /dev/fb0 -c:v libx264 -preset ultrafast -tune zerolatency -maxrate 2000k -bufsize 4000k -vf "hflip" -g 50 -f rtp_mpegts "rtp://10.10.106.103:20001" > /dev/null 2>&1
--> rtp 주소는 vlc 플레이할 PC 주소로.

=========== fb0에서 rtp 재생 ===========
ffmpeg -i "rtp://10.10.106.103:20001" -pix_fmt bgra -f fbdev /dev/fb0
ffmpeg -i "rtp://10.10.106.103:20001" -pix_fmt bgra -f fbdev /dev/fb0 > /dev/null 2>&1

=========== 수동 빌드 ============
/home/jimmyshin/Qt5.13.0/5.13.0/gcc_64/bin/qmake -o Makefile ../../../Trio_LCD.pro -spec linux-g++ CONFIG+=debug CONFIG+=qml_debug
make -j2
make clean -j2

/usr/local/Qt-5.13.0-aarch64-xwindow-multimedia/bin/qmake -o Makefile ../../../Trio_LCD.pro -spec linux-aarch64-gnu-g++ CONFIG+=qtquickcompiler
make -j2
make clean -j2

=========== windeployqt ============
windeployqt --release --qmldir "D:\Embedded\QT Projects\Trio_LCD" "TrioLCD.exe" // 필요 라이브러리 복사
binarycreator.exe -c config/config.xml -p packages "Trio_LCD_Setup.exe" // 설치 exe 생성

=========== Trio xWindow, TextMode ===========
sudo systemctl set-default multi-user.target // TextMode
sudo systemctl set-default graphical.target // xWindow

=========== TextMode 자동 로그인 ===========
sudo mkdir /etc/systemd/system/getty@tty1.service.d
sudo vi /etc/systemd/system/getty@tty1.service.d/autologin.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin 계정이름 --noclear %I 38400 linux
Type=
Type=simple

=========== Trio terminal welcome message ===========
/etc/update-motd.d/00-header
TERM=linux toilet -f standard -F metal -k "        Trio"
/etc/update-motd.d/10-help-text
printf " * Website: http://www.aibion.com\n"

== CUI terminal 90도 회전 ==
echo 1 > /sys/class/graphics/fbcon/rotate_all

linuxdeployqt Glance -qmldir=/home/jimmyshin/Qt5.13.0/5.13.0/gcc_64/qml/ -extra-plugins=platforms/libqlinuxfb.so -verbose=3
linuxdeployqt Glance -qmldir=/home/jimmyshin/Qt5.13.0/5.10.0/gcc_64/qml/ -extra-plugins=platforms/libqlinuxfb.so,platforminputcontexts/libqtvirtualkeyboardplugin.so -verbose=3

====================== 도어 내부 UI ======================
cp ../../../../build/desktop/release/SmartDoor_Inside/SmartDoor_Inside ./
linuxdeployqt SmartDoor_Inside -qmldir=/home/jimmyshin/Qt5.13.0/5.13.0/gcc_64/qml/ -extra-plugins=platforms/libqlinuxfb.so,generic/libqevdevtouchplugin.so -verbose=3
rsync -avz ./* bacs@192.168.111.87:/home/bacs/CrucialTrak/SmartDoor_Inside/

====================== 도어 외부 UI ======================
cp ../../../../build/desktop/release/SmartDoor_Outside/SmartDoor_Outside ./
linuxdeployqt SmartDoor_Outside -qmldir=/home/jimmyshin/Qt5.13.0/5.13.0/gcc_64/qml/ -extra-plugins=platforms/libqlinuxfb.so,generic/libqevdevtouchplugin.so -verbose=3
rsync -avz ./* bacs@192.168.111.87:/home/bacs/CrucialTrak/SmartDoor_Outside/

====================== Duo Rev2.0 UI ======================
cp ../Duo_Rev2 ./
linuxdeployqt Duo_Rev2 -qmldir=/home/jimmyshin/Qt5.13.0/5.13.0/gcc_64/qml/ -extra-plugins=platforms/libqlinuxfb.so,generic/libqevdevtouchplugin.so -verbose=3

~/withrobot/stop.sh
sudo killall BACSVerify Verify.sh

====================== rtp 테스트 url ======================
rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov

====================== 현재 폴더 png파일 IEC61966-2.1 -> sRGB built-in 일괄 변경 ======================
mogrify -format png *.*

====================== QtMultimedia 사용하려면 설치해야 하는 apt-get ======================
qml-module-qtmultimedia-gles
libc6
libgcc1
libqt5core5a
libqt5gui5
libqt5multimedia5
libqt5multimedia5-plugins
libqt5multimediaquick-p5
libqt5qml5
libqt5quick5
libqt5quick5-gles
libstdc++6
qml-module-qtquick2

====================== xcb 사용하려면 설치해야 하는 apt-get ======================
libxcb1-dev
libx11-dev
libx11-xcb-dev
libxext-dev
libxfixes-dev
libxi-dev
libxrender-dev
libxcb1-dev
libxcb-glx0-dev
libxcb-keysyms1
libxcb-keysyms1-dev
libxcb-image0-dev
libxcb-shm0-dev
libxcb-icccm4-dev
libxcb-sync-dev
libxcb-xfixes0-dev
libxcb-shape0-dev
libxcb-randr0-dev
libxcb-render-util0-dev
libxcb-xinerama0-dev
libxkbcommon-dev
libxkbcommon-x11-dev
build-essential

====================== Opengl 사용하려면 설치해야 하는 apt-get ======================
build-essential
libgl1-mesa-dev
libglu1-mesa-dev
libglut-dev
freeglut3-dev
mesa-common-dev
libsdl1.2-dev


====================== sysroot 당겨올 경로 ======================
rsync -avz root@192.168.16.25:/lib sysroot
rsync -avz root@192.168.16.25:/usr/include sysroot/usr
rsync -avz root@192.168.16.25:/usr/lib sysroot/usr
rsync -avz root@192.168.16.25:/opt/vc sysroot/opt

====================== rsync 포트 지정 ======================
rsync -avzog -e 'ssh -p 23' bacs@10.10.106.101:/lib sysroot

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

// 글랜스 arm64 xwindow 크로스컴파일 (in Ubuntu2.vdi)
../../qt-everywhere-src-5.13.0/configure -no-opengl -xplatform linux-aarch64-gnu-g++ -device-option CROSS_COMPILE=/usr/bin/aarch64-linux-gnu- -opensource -confirm-license -optimized-qmake -reduce-exports -release -make libs -sysroot ~/JimmyFolder2/installQt/GlanceBoard/sysroot -prefix /usr/local/Qt-5.13.0-aarch64-xwindow
// configure 성공, xcb 안깔림...

../../qt-everywhere-src-5.13.0/configure -qt-xcb -no-opengl -xplatform linux-aarch64-gnu-g++ -device-option CROSS_COMPILE=/usr/bin/aarch64-linux-gnu- -opensource -confirm-license -optimized-qmake -reduce-exports -release -make libs -sysroot ~/JimmyFolder2/installQt/GlanceBoard/sysroot -prefix /usr/local/Qt-5.13.0-aarch64-xwindow
// configure 성공, xcb 설정됨, 개발PC에 $sysroot/$prefix 에 넣어야 작동함.

현재 경로에서 실행 : /home/jimmyshin/JimmyFolder2/installQt/GlanceBoard/qt5build

../../qt-everywhere-src-5.13.0/configure -qt-xcb -no-opengl -xplatform linux-aarch64-gnu-g++ -device-option CROSS_COMPILE=/usr/bin/aarch64-linux-gnu- -opensource -confirm-license -optimized-qmake -reduce-exports -release -make libs -sysroot ~/JimmyFolder2/installQt/GlanceBoard/sysroot -extprefix /usr/local/Qt-5.13.0-aarch64-xwindow
// configure 성공, xcb 설정됨, 개발PC에 $extprefix 경로에 넣으면 잘 됨.
-> 보드에서 sudo apt-get install '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev 먼저 하고나서 sysroot 땡겨오기.

../../qt-everywhere-src-5.13.0/configure -qt-xcb -xplatform linux-aarch64-gnu-g++ -device-option CROSS_COMPILE=/usr/bin/aarch64-linux-gnu- -opensource -confirm-license -optimized-qmake -reduce-exports -release -make libs -sysroot ~/JimmyFolder2/installQt/GlanceBoard/sysroot -extprefix /usr/local/Qt-5.13.0-aarch64-xwindow-multimedia

../../qt-everywhere-src-5.13.0/configure -qt-xcb -opengl desktop -qt-libpng -qt-libjpeg -qt-freetype -make libs -xplatform linux-aarch64-gnu-g++ -device-option CROSS_COMPILE=/usr/bin/aarch64-linux-gnu- -opensource -confirm-license -optimized-qmake -reduce-exports -release -make libs -sysroot ~/JimmyFolder2/installQt/GlanceBoard/sysroot -extprefix /usr/local/Qt-5.13.0-aarch64-xwindow-multimedia
// configure 성공, xcb 설정됨, opengl 설정됨, 개발PC에 $extprefix 경로에 넣으면 잘 됨.
-> 보드에서 sudo apt-get install '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev 먼저 하고나서 sysroot 땡겨오기.
