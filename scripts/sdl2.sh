#!/bin/bash

##################################################################
# Created by Christian Haitian for use to easily update          #
# various standalone emulators, libretro cores, and other        #
# various programs for the RK3566 platform for various Linux     #
# based distributions.                                           #
# See the LICENSE.md file at the top-level directory of this     #
# repository.                                                    #
##################################################################

cur_wd="$PWD"
bitness="$(getconf LONG_BIT)"
#commit="25f9ed87ff6947d9576fc9d79dee0784e638ac58" # SDL 2.0.16
#commit="f9b918ff403782986f2a6712e6e2a462767a0457" # SDL 2.0.20 although it builds as 2.0.18.2 ¯\_(ツ)_/¯
commit="f070c83a6059c604cbd098680ddaee391b0a7341" # SDL 2.0.26.2

	# sdl2 Standalone Build
	if [[ "$var" == "sdl2" ]]; then
	 cd $cur_wd

	  # Now we'll start the clone and build process of sdl2
	  if [ ! -d "SDL/" ]; then
		git clone https://github.com/libsdl-org/SDL
		if [[ $? != "0" ]]; then
		  echo " "
		  echo "There was an error while cloning the sdl2 standalone git.  Is Internet active or did the git location change?  Stopping here."
		  exit 1
		fi
		cp patches/sdl2-patch* SDL/.
	  else
		echo " "
		echo "A sdl2 subfolder already exists.  Stopping here to not impact anything in the folder that may be needed.  If not needed, please remove the sdl2 folder and rerun this script."
		echo " "
		exit 1
	  fi

	 cd SDL
     git checkout $commit

	 sdl2_patches=$(find *.patch)
	 
	 if [[ ! -z "$sdl2_patches" ]]; then
	  for patching in sdl2-patch*
	  do
		 if [[ $patching == *"odroidgoa"* ]]; then
		   echo " "
		   echo "Skipping the $patching for now and making a note to apply that later"
		   sleep 3
		   sdl2_rotationpatch="yes"
		 else
		   patch -Np1 < "$patching"
		   if [[ $? != "0" ]]; then
			echo " "
			echo "There was an error while applying $patching.  Stopping here."
			exit 1
		   fi
		   rm "$patching"
		 fi
	  done
	 fi

        if [[ $bitness == "32" ]]; then
         ./autogen.sh
         ./configure --host=arm-linux-gnueabihf \
         --enable-video-kmsdrm \
         --disable-video-x11 \
         --disable-video-rpi \
         --disable-video-wayland \
         --disable-video-vulkan
       else
         mkdir build
         cd build
         cmake -DSDL_STATIC=OFF \
               -DLIBC=ON \
               -DGCC_ATOMICS=ON \
               -DALTIVEC=OFF \
               -DOSS=OFF \
               -DALSA=ON \
               -DALSA_SHARED=ON \
               -DJACK=OFF \
               -DJACK_SHARED=OFF \
               -DESD=OFF \
               -DESD_SHARED=OFF \
               -DARTS=OFF \
               -DARTS_SHARED=OFF \
               -DNAS=OFF \
               -DNAS_SHARED=OFF \
               -DLIBSAMPLERATE=ON \
               -DLIBSAMPLERATE_SHARED=OFF \
               -DSNDIO=OFF \
               -DDISKAUDIO=OFF \
               -DDUMMYAUDIO=OFF \
               -DVIDEO_WAYLAND=OFF \
               -DVIDEO_WAYLAND_QT_TOUCH=OFF \
               -DWAYLAND_SHARED=OFF \
               -DVIDEO_MIR=OFF \
               -DMIR_SHARED=OFF \
               -DVIDEO_COCOA=OFF \
               -DVIDEO_DIRECTFB=OFF \
               -DVIDEO_VIVANTE=OFF \
               -DDIRECTFB_SHARED=OFF \
               -DFUSIONSOUND=OFF \
               -DFUSIONSOUND_SHARED=OFF \
               -DVIDEO_DUMMY=OFF \
               -DINPUT_TSLIB=OFF \
               -DPTHREADS=ON \
               -DPTHREADS_SEM=ON \
               -DDIRECTX=OFF \
               -DSDL_DLOPEN=ON \
               -DCLOCK_GETTIME=OFF \
               -DRPATH=OFF \
               -DRENDER_D3D=OFF \
               -DVIDEO_X11=OFF \
               -DVIDEO_OPENGL=OFF \
               -DVIDEO_OPENGLES=ON \
               -DVIDEO_VULKAN=OFF \
               -DVIDEO_KMSDRM=ON \
               -DPULSEAUDIO=ON ..
          export LDFLAGS="${LDFLAGS} -lrga"
       fi

      #../configure --prefix=$PWD/bin$bitness
	  #make clean
	  make -j$(nproc)
	  #make install

	  if [[ $? != "0" ]]; then
		echo " "
		echo "There was an error while building sdl2 at commit $commit.  Stopping here."
		exit 1
	  fi

      if [[ $bitness == "32" ]]; then
	     strip build/.libs/libSDL2-2.0.so.0.*
	  else
	     strip libSDL2-2.0.so.0.*
	  fi

	  if [ ! -d "$cur_wd/sdl2-$bitness/" ]; then
		mkdir -v $cur_wd/sdl2-$bitness
	  fi

      if [[ $bitness == "32" ]]; then
	     cp build/.libs/libSDL2-2.0.so.0.* $cur_wd/sdl2-$bitness/.
	  else
	     cp libSDL2-2.0.so.0.* $cur_wd/sdl2-$bitness/.
	  fi

	  echo " "
	  echo "sdl $(git describe --tags | cut -c 9-) has been created and has been placed in the rk3566_core_builds/sdl2-$bitness subfolder"
	fi
