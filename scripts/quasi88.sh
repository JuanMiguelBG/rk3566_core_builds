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

	# Libretro quasi88 build
	if [[ "$var" == "quasi88" || "$var" == "all" ]] && [[ "$bitness" == "64" ]]; then
	 cd $cur_wd
	  if [ ! -d "quasi88-libretro/" ]; then
		git clone https://github.com/libretro/quasi88-libretro.git
		if [[ $? != "0" ]]; then
		  echo " "
		  echo "There was an error while cloning the libretro git.  Is Internet active or did the git location change?  Stopping here."
		  exit 1
		 fi
		cp patches/quasi88-patch* quasi88-libretro/.
	  fi

	 cd quasi88-libretro/
	 
	 quasi88_patches=$(find *.patch)
	 
	 if [[ ! -z "$quasi88_patches" ]]; then
	  for patching in quasi88-patch*
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

	  make clean
	  make -j$(nproc)

	  if [[ $? != "0" ]]; then
		echo " "
		echo "There was an error while building the newest lr-quasi88 core.  Stopping here."
		exit 1
	  fi

	  strip quasi88_libretro.so

	  if [ ! -d "../cores64/" ]; then
		mkdir -v ../cores64
	  fi

	  cp quasi88_libretro.so ../cores64/.

	  gitcommit=$(git log | grep -m 1 commit | cut -c -14 | cut -c 8-)
	  echo $gitcommit > ../cores$(getconf LONG_BIT)/quasi88_libretro.so.commit

	  echo " "
	  echo "quasi88_libretro.so has been created and has been placed in the rk3566_core_builds/cores64 subfolder"
	fi
