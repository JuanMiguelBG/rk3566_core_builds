# Script to automate the build of various Libretro cores, Nxengine-evo, Retroarch, PPSSPP, ScummVM, Emulationstation-fcamod for use with RK3566 devices (such as the RG503)

### Assumptions:
This script was designed to work with 32bit and 64bit chroot Linux environments for the RK3326 chipset. \
See [this document](https://github.com/christianhaitian/rk3566_core_builds/blob/main/docs/chroot.md) for instructions on how to create them yourself. \
You can also download a prebuilt one I created by following the information [here](https://forum.odroid.com/viewtopic.php?p=306185#p306185)

This script is designed to only build cores, retroarch and some standalone emulators and applications that are compatible with the aarch64 or armhf environment it's run from.  So to build cores for the 32bit armhf environment, it should be run from an arm32 environment such as a 32bit chroot.

## How to use: (In a aarch64 chroot or armhf chroot or building from Ubuntu based distro on a RK3566 device)

```
git clone https://github.com/christianhaitian/rk3566_core_builds.git
cd rk3566_core_builds
```

### To build all libretro core scripts except for mame and mess ones:
`./builds.sh all`

### To build all libretro core scripts including mame and mess ones (Warning, a very long build.  Maybe even over 24 hours!):
`./builds.sh ALL`

### To build just 81 (64bit only):
`./builds.sh 81`

### To build just a5200 (64bit only):
`./builds.sh a5200`

### To build just arduous (64bit only):
`./builds.sh arduous`

### To build just atari800 (64bit only):
`./builds.sh atari800`

### To build just bluemsx (64bit only):
`./builds.sh bluemsx`

### To build just caprice32 (64bit only):
`./builds.sh cap32`

### To build just crocods (64bit only):
`./builds.sh crocods`

### To build just desmume2015 (64bit only):
`./builds.sh desmume2015`

### To build devilutionX (64bit only)
`./builds.sh devilutionx`

### To build just dolphin standalone emulator (64bit only):
`./builds.sh dolphinsa`

### To build just dosbox_pure (64bit only):
`./builds.sh dosbox_pure`

### To download and unpack duckstation (64bit only):
`./builds.sh duckstation`

### To build just duckstation standalone emulator (64bit only):
`./builds.sh duckstationsa`

### To build just easyrpg (64bit only):
`./builds.sh easyrpg`

### To build just ecwolf standalone emulator (64bit only):
`./builds.sh ecwolfsa

### To build just fake08 standalone emulator (64bit only):
`./builds.sh fake08sa`

## To build just fake08 (64bit only):
`./builds.sh fake08`

### To build just fbneo (64bit only):
`./builds.sh fbneo`

### To build just fbneo standalone emulator (64bit only):
`./builds.sh fbneosa`

### To build just freeintv:
`./builds.sh freeintv`

### To build just gambatte (64bit only):
`./builds.sh gambatte`

### To build just genesis-plus-gx (64bit only):
`./builds.sh genesis-plus-gx`

### To build just genesis-plus-gx-wide (64bit only):
`./builds.sh genesis-plus-gx-wide`

### To build just gpsp:
`./builds.sh gpsp`

### To build just gzdoom standalone (64bit only):
`./build.sh gzdoom`

### To build just handy (64bit only):
`./builds.sh handy`

### To build just fceumm (64bit only):
`./builds.sh fceumm`

### To build just flycast:
`./builds.sh flycast`

### To build just flyinghead's flycast core:
`./builds.sh fly_flycast`

### To build just fmsx (64bit only):
`./builds.sh fmsx`

### To build just freeintv core (64bit only):
`./builds.sh freeintv`

### To build just freechaf core (64bit only):
`./builds.sh freechaf`

### To build just hypseus (64bit only):
`./builds.sh hypseus`

### To build just hypseus-singe (64bit only):
`./builds.sh hypseus-singe`

### To build just lynx (64bit only):
`./builds.sh lynx`

##To build just mame (64bit only); <--Very long build.  Could be 24 hours or more to complete.
`./builds.sh mame`

### To build just mame2000 (64bit only):
`./builds.sh mame2000`

### To build just mame2003 (64bit only):
`./builds.sh mame2003`

### To build just mame2003-plus (64bit only):
`./builds.sh mame2003-plus`

### To build just mame2010 (64bit only):
`./builds.sh mame2010`

### To build just mednafen Standalone emulator (64bit only):
`./builds.sh mednafen`

### To build just melonds (64bit only):
`./builds.sh melonds`

### To build just mesen (64bit only):                                                            
`./builds.sh mesen`

### To build just mess (64bit only): <--Very long build.  Could be 24 hours or more to complete.
`./builds.sh mess`

### To build just mgba (64bit only):
`./builds.sh mgba`

### To build just microvision Standalone emulator:
`./builds.sh microvisionsa`

### To build just mupen64plus-next:
`./builds.sh mupen64plus-nx`

### To build just mupen64plus Standalone emulator:
`./builds.sh mupen64plussa`

### To build just nekop2 (64bit only):
`./builds.sh nekop2`

### To build just neocd (64bit only):
`./builds.sh neocd`

### To build just nestopia (64bit only):
`./builds.sh nestopia`

### To build just ngp (64bit only):
`./builds.sh ngp`

### To build just np2kai (64bit only):
`./builds.sh np2kai`

### To build just o2em (64bit only):
`./builds.sh o2em`

### To build just openmsx standalone emulator (64bit only):
`./builds.sh openmsx`

### To build just opera (64bit only):
`./builds.sh opera`

### To build just potator (64bit only):
`./builds.sh potator`

### To build just pce_fast (64bit Only):
`./builds.sh pce_fast`

### To build just pcfx (64bit Only):
`./builds.sh pcfx`

### To build just prboom (64bit Only):
`./builds.sh prboom`

### To build just prosystem (64bit Only):
`./builds.sh prosystem`

### To build just puae (64bit Only):
`./builds.sh puae`

### To build just puae2021 (64bit Only):
`./builds.sh puae2021`

### To build just px68k (64bit Only):
`./builds.sh px68k`

### To build just pokemini (64bit only):
`./builds.sh pokemini`

### To build just parallel-n64:
`./builds.sh parallel-n64`

### To build just picodrive:
`./builds.sh picodrive`

### To build just pcsx_rearmed (32bit only):
`./builds.sh pcsx_rearmed`

### To build just ppsspp standalone emulator (64bit only):
`./builds.sh ppsspp`

### To build just libretro-ppsspp (64bit only):
`./builds.sh ppsspp-libretro`

### To build just quasi88 (64bit only):
`./builds.sh quasi88`

### To build just race (64bit only):
`./builds.sh race`

### To build just same_cdi (64bit only):
`./builds.sh samecdi`

### To build just sameboy (64bit only):
`./builds.sh sameboy`

### To build just sameduck (64bit only):
`./builds.sh sameduck`

### To build just scummvm standalone:
`./builds.sh scummvm`

### To build just scummvm libretro (64bit only):
`./builds.sh scummvm-libretro`

### To build just solarus standalone (64bit only):
`./builds.sh solarus`

### To build just snes9x (64bit only):
`./builds.sh snes9x`

### To build just snes9x2005:
`./builds.sh snes9x2005`

### To build just supafaust (64bit only):
`./builds.sh supafaust`

### To build just supergrafx (64bit Only):
`./builds.sh supergrafx`

### To build just swanstation (64bit Only):
`./build.sh swanstation`

### To build just tic-80 (64bit only):
`./builds.sh tic-80`

### To build just quicknes (64bit only):
`./builds.sh quicknes`

### To build just uae4arm:
`./builds.sh uae4arm`

### To build just uzem:
`./builds.sh uzem`

### To build just vbam (64bit only):
`./builds.sh vbam`

### To build just vba-next (64bit only):
`./builds.sh vba-next`

### To build just vectrex (64bit only):
`./builds.sh vectrex`

### To build just vemulator:
`./builds.sh vemulator`

### To build just vice cores:
`./builds.sh vice`

### To build just virtualboy (64bit only):
`./builds.sh vb`

### To build just virtualjaguar:
`./builds.sh virtualjaguar`

### To build just yabasanshiro (32bit only):
`./builds.sh yabasanshiro`

### To build just yabasanshiro standalone:
`./builds.sh yabasanshirosa`

### To build just yabause:
`./builds.sh yabause`

### To build just x1 (64bit only):
`./builds.sh x1`

### To build just retroarch:
`./builds.sh retroarch`

### To build Nxegnine-evo (64bit only)
`./builds.sh nxengine-evo`

### To add a system for screenscraper scraping in Emulationstation-fcamod (64bit only)
`./builds.sh es_add_scrape`

### To build Emulationstation-fcamod (64bit only)
`./builds.sh es_build`

### To build SDL 2.0.16
`./builds.sh sdl2`

### To update the retroarch-cores repo with new or updated cores:
`./builds.sh update`

### To clean the folder of all builds and gits
`./builds.sh clean`
