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

	# Libretro tic-80 build
	if [[ "$var" == "tic-80" || "$var" == "all" ]] && [[ "$bitness" == "64" ]]; then
	 cd $cur_wd
	  if [ ! -d "tic-80/" ]; then
		git clone --recursive https://github.com/nesbox/tic-80.git
		if [[ $? != "0" ]]; then
		  echo " "
		  echo "There was an error while cloning the libretro git.  Is Internet active or did the git location change?  Stopping here."
		  exit 1
		 fi
		cp patches/tic80-patch* tic-80/.
	  fi

	 cd tic-80/
	 
	 tic80_patches=$(find *.patch)
	 
	 if [[ ! -z "$tic80_patches" ]]; then
	  for patching in tic80-patch*
	  do
		   patch -Np1 < "$patching"
		   if [[ $? != "0" ]]; then
			echo " "
			echo "There was an error while applying $patching.  Stopping here."
			exit 1
		   fi
		   rm "$patching" 
	  done
	 fi

      cmake -DCMAKE_BUILD_TYPE=MinSizeRel -DBUILD_WITH_MRUBY=OFF -DBUILD_PLAYER=ON -DBUILD_SOKOL=OFF -DBUILD_SDL=OFF -DBUILD_DEMO_CARTS=OFF -DBUILD_LIBRETRO=ON .
	  make clean
	  make -j$(nproc)

	  if [[ $? != "0" ]]; then
		echo " "
		echo "There was an error while building the newest lr-tic-80 core.  Stopping here."
		exit 1
	  fi

	  strip lib/tic80_libretro.so

	  if [ ! -d "../cores64/" ]; then
		mkdir -v ../cores64
	  fi

	  cp lib/tic80_libretro.so ../cores64/.

	  gitcommit=$(git log | grep -m 1 commit | cut -c -14 | cut -c 8-)
	  echo $gitcommit > ../cores$(getconf LONG_BIT)/tic80_libretro.so.commit

	  echo " "
	  echo "tic80_libretro.so has been created and has been placed in the rk3566_core_builds/cores64 subfolder"
	fi
