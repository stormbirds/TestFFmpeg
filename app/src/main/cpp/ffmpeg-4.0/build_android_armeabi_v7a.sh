#!/bin/bash

# 设置临时文件夹，需要提前手动创建
export TMPDIR="/home/edcc/AndroidStudioProjects/FFmpeg4Android/ffmpeg-4.0/ffmpegtemp"

# 设置NDK路径
NDK=/var/www/android-ndk-r14b-linux-x86_64/android-ndk-r14b

# 设置编译针对的平台，可以根据自己的需求进行设置
# 当前设置为最低支持android-14版本，arm架构
SYSROOT=$NDK/platforms/android-14/arch-arm/

# 设置编译工具链，4.9为版本号
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64

function build_one
{
./configure \
    --enable-cross-compile \
    --enable-gpl \
    --enable-version3 \
    --enable-nonfree \
    --enable-shared \
    --disable-static \
    --disable-doc \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --enable-avdevice \
    --enable-postproc \
    --enable-small \
    --disable-doc \
    --disable-symver \
    --prefix=$PREFIX \
    --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
    --target-os=android \
    --arch=$CPU \
    --sysroot=$SYSROOT \

$ADDITIONAL_CONFIGURE_FLAG
make clean
make
make install
}

# 设置编译后的文件输出目录
CPU=armv7-a
PREFIX=$(pwd)/android/$CPU
build_one
