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
valid_id='^[0-9]+$'
es_git="https://github.com/christianhaitian/EmulationStation-fcamod.git"
bitness="$(getconf LONG_BIT)"

	# Emulationstation scraping adds
	if [[ "$var" == "es_add_scrape" ]] && [[ "$bitness" == "64" ]]; then

	 echo "What branch of emulationstation-fcamod are we working with?"
	 echo "1 for master, 2 for 503, 3 for 351v, 4 for all"
	 read branchnum
	 if [ "$branchnum" -lt 1 ] || [ "$branchnum" -gt 4 ]; then
	   echo "$branchnum is not a valid option.  Exiting."
	   exit 1
	 fi
	 if ! [[ $branchnum =~ $valid_id ]]; then
	   echo "$branchnum is not a number.  Exiting."
	   exit 1
	 fi
	 echo "What platform name to add? (ex. platform set in es_systems.cfg file)"
	 read string
	 echo "What Platform ID to add?"
	 read platform_id
	 echo "What is the screenscraper ID number to add? (Can be found by going to screenscraper.fr and selecting a platform and see what platforme is equal to in the url)"
	 read ss_id
	 if ! [[ $ss_id =~ $valid_id ]]; then
	   echo "$ss_id is not a number.  Exiting."
	   exit 1
	 fi

	 case "$branchnum" in
		 "1")
			cd $cur_wd
			branch="master"
			if [ ! -d "emulationstation-fcamod-$branch/" ]; then
			  git clone --recursive $es_git -b $branch emulationstation-fcamod-$branch
			  if [[ $? != "0" ]]; then
				echo " "
				echo "There was an error while cloning the $branch branch of the emulationstation-fcamod git.  Is Internet active or did the git location change?  Stopping here."
				exit 1
			  fi
			fi 
			cd emulationstation-fcamod-$branch
			sed -i '/TI99 },/c\\t\t{ \"ti99\", \t\t\t\t\tTI99 },\n\t\t{ \"'$string'\", \t\t\t'$platform_id' },' es-app/src/PlatformId.cpp
			sed -i '/TI99,/c\\t\tTI99,\n\t\t'$platform_id',' es-app/src/PlatformId.h
			sed -i '/{ TI99, 205 },/c\\t{ TI99, 205 },\n\t{ '$platform_id', '$ss_id' },' es-app/src/scrapers/ScreenScraper.cpp
			exit 0
			;;
		 "2")
			cd $cur_wd
			branch="503noTTS"
			if [ ! -d "emulationstation-fcamod-$branch/" ]; then
			  git clone --recursive $es_git -b $branch emulationstation-fcamod-$branch
			  if [[ $? != "0" ]]; then
				echo " "
				echo "There was an error while cloning the $branch branch of the emulationstation-fcamod git.  Is Internet active or did the git location change?  Stopping here."
				exit 1
			  fi
			fi 
			cd emulationstation-fcamod-$branch
			sed -i '/TI99 },/c\\t\t{ \"ti99\", \t\t\t\t\tTI99 },\n\t\t{ \"'$string'\", \t\t\t'$platform_id' },' es-app/src/PlatformId.cpp
			sed -i '/TI99,/c\\t\tTI99,\n\t\t'$platform_id',' es-app/src/PlatformId.h
			sed -i '/{ TI99, 205 },/c\\t{ TI99, 205 },\n\t{ '$platform_id', '$ss_id' },' es-app/src/scrapers/ScreenScraper.cpp
			exit 0
		 ;;
		 "3")
			cd $cur_wd
			branch="351v"
			if [ ! -d "emulationstation-fcamod-$branch/" ]; then
			  git clone --recursive $es_git -b $branch emulationstation-fcamod-$branch
			  if [[ $? != "0" ]]; then
				echo " "
				echo "There was an error while cloning the $branch branch of the emulationstation-fcamod git.  Is Internet active or did the git location change?  Stopping here."
				exit 1
			  fi
			fi 
			cd emulationstation-fcamod-$branch
			sed -i '/TI99 },/c\\t\t{ \"ti99\", \t\t\t\t\tTI99 },\n\t\t{ \"'$string'\", \t\t\t'$platform_id' },' es-app/src/PlatformId.cpp
			sed -i '/TI99,/c\\t\tTI99,\n\t\t'$platform_id',' es-app/src/PlatformId.h
			sed -i '/{ TI99, 205 },/c\\t{ TI99, 205 },\n\t{ '$platform_id', '$ss_id' },' es-app/src/scrapers/ScreenScraper.cpp
			exit 0
		 ;;
		 "4")
			for branch in 351v 503noTTS master fullscreen rgb10max
			do
			  cd $cur_wd
			  if [ ! -d "emulationstation-fcamod-$branch/" ]; then
			    git clone --recursive $es_git -b $branch emulationstation-fcamod-$branch
			    if [[ $? != "0" ]]; then
				  echo " "
				  echo "There was an error while cloning the $branch branch of the emulationstation-fcamod git.  Is Internet active or did the git location change?  Stopping here."
				  exit 1
			    fi
			  fi 
			  cd emulationstation-fcamod-$branch
			  sed -i '/TI99 },/c\\t\t{ \"ti99\", \t\t\t\t\tTI99 },\n\t\t{ \"'$string'\", \t\t\t'$platform_id' },' es-app/src/PlatformId.cpp
			  sed -i '/TI99,/c\\t\tTI99,\n\t\t'$platform_id',' es-app/src/PlatformId.h
			  sed -i '/{ TI99, 205 },/c\\t{ TI99, 205 },\n\t{ '$platform_id', '$ss_id' },' es-app/src/scrapers/ScreenScraper.cpp
              git add .
              git commit -m "Added $string with a screenscraper ID of $ss_id"
            done
            exit 0
		 ;;
		 *)
			echo "I don't understand $branchnum.  Try again."
			exit 0
	 esac
	fi
