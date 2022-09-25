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

	# Libretro vectrex build
	if [[ "$var" == "vectrex" || "$var" == "all" ]] && [[ "$bitness" == "64" ]]; then
	 cd $cur_wd
	  if [ ! -d "libretro-vecx/" ]; then
		git clone --recursive https://github.com/libretro/libretro-vecx.git
		if [[ $? != "0" ]]; then
		  echo " "
		  echo "There was an error while cloning the libretro git.  Is Internet active or did the git location change?  Stopping here."
		  exit 1
		 fi
		cp patches/vectrex-patch* libretro-vecx/.
	  fi

	 cd libretro-vecx/
	 
	 vectrex_patches=$(find *.patch)
	 
	 if [[ ! -z "$vectrex_patches" ]]; then
	  for patching in vectrex-patch*
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
	  make -f Makefile.libretro HAS_GPU=1 HAS_GLES=1 -j$(nproc)

	  if [[ $? != "0" ]]; then
		echo " "
		echo "There was an error while building the newest lr-vectrex core.  Stopping here."
		exit 1
	  fi

	  strip vecx_libretro.so

	  if [ ! -d "../cores64/" ]; then
		mkdir -v ../cores64
	  fi

	  cp vecx_libretro.so ../cores64/.

	  gitcommit=$(git log | grep -m 1 commit | cut -c -14 | cut -c 8-)
	  echo $gitcommit > ../cores$(getconf LONG_BIT)/vecx_libretro.so.commit

	  echo " "
	  echo "vecx_libretro.so has been created and has been placed in the rk3566_core_builds/cores64 subfolder"
	fi
