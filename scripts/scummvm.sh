#!/bin/bash
cur_wd="$PWD"
bitness="$(getconf LONG_BIT)"

	# Scummvm Standalone Build
	if [[ "$var" == "scummvm" ]]; then
	 cd $cur_wd

	  # Now we'll start the clone and build process of scummvm
	  if [ ! -d "scummvm/" ]; then
		git clone https://github.com/scummvm/scummvm.git
		if [[ $? != "0" ]]; then
		  echo " "
		  echo "There was an error while cloning the scummvm standalone git.  Is Internet active or did the git location change?  Stopping here."
		  exit 1
		fi
		cp patches/scummvm-patch* scummvm/.
	  else
		echo " "
		echo "A scummvm subfolder already exists.  Stopping here to not impact anything in the folder that may be needed.  If not needed, please remove the scummvm folder and rerun this script."
		echo " "
		exit 1
	  fi

	 cd scummvm/

	 # Ensure dependencies are installed and available
	 apt-get update
	 apt-get -y install --no-install-recommends libsdl2-dev liba52-0.7.4-dev libjpeg62-turbo-dev libmpeg2-4-dev libogg-dev libvorbis-dev libflac-dev libmad0-dev libpng-dev libtheora-dev libfaad-dev libfluidsynth-dev libfreetype6-dev libcurl4-openssl-dev libsdl2-net-dev libspeechd-dev zlib1g-dev libfribidi-dev libglew-dev
	 if [[ $? != "0" ]]; then
	   echo " "
	   echo "There was an error while installing the necessary dependencies.  Is Internet active?  Stopping here."
	   exit 1
	 fi 

	  ./configure --backend=sdl --enable-optimizations --opengl-mode=gles2 --enable-vkeybd --disable-debug --enable-release
	  make clean
	  make -j$(nproc)

	  if [[ $? != "0" ]]; then
		echo " "
		echo "There was an error while building the newest scummvm.  Stopping here."
		exit 1
	  fi

	  strip scummvm
	  
	  mkdir extra
	  mkdir themes
	  cp backends/vkeybd/packs/*.zip extra/.
	  cp dists/pred.dic extra.
	  cp dists/engine-data/*.dat extra/.
	  cp gui/themes/*.zip themes/.
	  cp gui/themes/translations.dat themes/. 
	  echo "19000000030000000300000002030000,gameforce_gamepad,leftstick:b14,rightx:a3,leftshoulder:b4,start:b9,lefty:a0,dpup:b10,righty:a2,a:b1,b:b0,guide:b16,dpdown:b11,rightshoulder:b5,righttrigger:b7,rightstick:b15,dpright:b13,x:b2,back:b8,leftx:a1,y:b3,dpleft:b12,lefttrigger:b6,platform:Linux,
190000004b4800000010000000010000,GO-Advance Gamepad,a:b1,b:b0,x:b2,y:b3,leftshoulder:b4,rightshoulder:b5,dpdown:b7,dpleft:b8,dpright:b9,dpup:b6,leftx:a0,lefty:a1,leftstick:b10,guide:b12,lefttrigger:b11,rightstick:b13,righttrigger:b14,start:b15,platform:Linux,
190000004b4800000010000001010000,GO-Advance Gamepad (rev 1.1),a:b1,b:b0,x:b2,y:b3,leftshoulder:b4,rightshoulder:b5,dpdown:b9,dpleft:b10,dpright:b11,dpup:b8,leftx:a0,lefty:a1,guide:b12,leftstick:b14,lefttrigger:b13,rightstick:b15,righttrigger:b16,start:b17,platform:Linux,
190000004b4800000011000000010000,GO-Super Gamepad,platform:Linux,x:b2,a:b1,b:b0,y:b3,back:b12,guide:b16,start:b13,dpleft:b10,dpdown:b9,dpright:b11,dpup:b8,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftstick:b14,rightstick:b17,leftx:a0,lefty:a1,rightx:a2,righty:a3,platform:Linux,
03000000091200000031000011010000,OpenSimHardware OSH PB Controller,a:b1,b:b0,x:b3,y:b2,leftshoulder:b4,rightshoulder:b5,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,leftx:a0~,lefty:a1~,guide:b10,leftstick:b8,lefttrigger:b13,rightstick:b9,back:b7,start:b6,rightx:a2,righty:a3,righttrigger:b11,platform:Linux," > extra/gamecontrollerdb.txt

	  if [ ! -d "../scummvm$bitness/" ]; then
		mkdir -v ../scummvm$bitness
	  fi

	  cp scummvm ../scummvm$bitness/.
	  tar -zchvf ../scummvm$bitness/scummvm_pkg_$(git rev-parse HEAD | cut -c -7).tar.gz extra/ themes/ scummvm AUTHORS COPYING COPYING.* NEWS.md README.md

	  echo " "
	  echo "scummvm has been created and has been placed in the rk3326_core_builds/scummvm$bitness subfolder"
	fi


	# Clean up the directory and remove other lr gits and created cores
	if [ "$var" == "clean" ]; then
	  find -maxdepth 1 ! -name patches ! -name .git ! -name docs -type d -not -path '.' -exec rm -rf {} +
	  mkdir cores$bitness
	  echo " "
	  echo "Directory has been cleaned!"
	fi

	if [ -d "$cur_wd/cores$bitness" ]; then
	  if [ "$(ls -A $cur_wd/cores$bitness)" ]; then
		echo " "
		echo "The cores$bitness folder currently contains the following:"
		ls -l $cur_wd/cores$bitness
	  fi
	fi
	if [ -d "$cur_wd/retroarch$bitness" ]; then
	  if [ "$(ls -A $cur_wd/retroarch$bitness)" ]; then
		echo " "
		echo "The retroarch$bitness folder currently contains the following:"
		ls -l $cur_wd/retroarch$bitness
	  fi
	fi
	if [ -d "$cur_wd/es-fcamod" ]; then
	  if [ "$(ls -A $cur_wd/es-fcamod)" ]; then
		echo " "
		echo "The es-fcamod folder currently contains the following:"
		ls -l $cur_wd/es-fcamod
	  fi
	fi