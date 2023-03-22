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

	# Libretro puae2021 build
	if [[ "$var" == "puae2021" || "$var" == "all" ]] && [[ "$bitness" == "64" ]]; then
	 cd $cur_wd
	  if [ ! -d "libretro-uae/" ]; then
		git clone https://github.com/libretro/libretro-uae.git -b 2.6.1
		if [[ $? != "0" ]]; then
		  echo " "
		  echo "There was an error while cloning the libretro git.  Is Internet active or did the git location change?  Stopping here."
		  exit 1
		 fi
		cp patches/puae2021-patch* libretro-uae/.
	  fi

	 cd libretro-uae/
	 
	 puae2021_patches=$(find *.patch)
	 
	 if [[ ! -z "$puae2021_patches" ]]; then
	  for patching in puae2021-patch*
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

          sed -i '/armv8-a+crc+simd/s//armv8.2-a+crc+simd/g' Makefile
	  sed -i '/cortex-a72/s//cortex-a55/g' Makefile
	  sed -i '/rpi4/s//rk3566/' Makefile
	  make clean
	  make platform=rk3566 -j$(nproc)

	  if [[ $? != "0" ]]; then
		echo " "
		echo "There was an error while building the newest lr-puae2021 core.  Stopping here."
		exit 1
	  fi

	  strip puae2021_libretro.so

	  if [ ! -d "../cores64/" ]; then
		mkdir -v ../cores64
	  fi

	  cp puae2021_libretro.so ../cores64/.

	  gitcommit=$(git log | grep -m 1 commit | cut -c -14 | cut -c 8-)
	  echo $gitcommit > ../cores$(getconf LONG_BIT)/puae2021_libretro.so.commit

	  echo " "
	  echo "puae2021_libretro.so has been created and has been placed in the rk3566_core_builds/cores64 subfolder"
	fi
