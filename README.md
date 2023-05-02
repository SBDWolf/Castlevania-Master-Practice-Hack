# Castlevania-Master-Practice-Hack
A speedrunning practice hack of the NES Castlevania.

This hack aim to unify various useful tools that prior to this have been floating around as individual patches, as well as add some additional features.

To use, pause the game by pressing Start, then press Select to pull up a menu.

## Features List

### Stage Control
- **Reset Stage**: Brings Simon back to the start of the current stage. Subweapon, Multiplier, and Heart Count are preserved.
- **Stage Select**: Brings Simon to the start of the selected stage. Subweapon, Multiplier, and Heart Count are preserved.
### Player Stats
- **Whip Level**: Sets Simon's Whip Strength.
  - 00 = Leather Whip
  - 01 = Short Whip
  - 02 = Long Whip
- **Subweapon**: Sets Simon's Subweapon.
- **Multiplier**: Sets Simon's Multiplier for the Subweapon.
  - 00 = No Multiplier
  - 01 = Double Shot
  - 02 = Triple Shot
- **Hearts**: Sets Simon's Heart Count.
- **Game Loop**: Sets whether the game's difficulty setting is that of first quest or second quest.
  - 00 = First Quest
  - 01 = Second Quest
### Practice Tools
Keep in mind that having any of these tools enabled may cause a little bit more lag. They are all disabled by default.
- **Viewer 1,2,3,4**: Sets a memory watch around the top left side of the screen. There are 4 slots available, so you can have up to 4 memory values displayed at the same time. The options are the following:
  - **Simon K**: The most significant byte of Simon's X position on screen (sorry for the name, Castlevania's tileset doesn't have an X character :) )
  - **Simon Y**: Simon's Y position on screen
  - **Whip Frames**: The animation timer for Simon's Whip. Particularly useful for Crit practice, since it freezes when Simon gets hit. You want this value to be frozen at 0x11 when getting hit.
  - **Boss Health**: The numerical value of the boss's health for the current stage.
  - **Blk Counter**: The index for the block that's being processed in a column by Castlevania's stage loading algorithm. Can be useful for Scroll Glitch practice.
- **Timer**: Enables an in-game timer.
  This timer will not visually update on screen, but rather on stage and level transitions.
  The format for this timer is 1M23.45 (reads: 1 minute, 23 seconds and 45 frames). One second is assumed to be exactly equal to 60 frames, even though technically a   real time second is actually 60.098 frames.

  There are two components to this: a room timer, and a level timer. Again, these will both only get printed on screen on stage and level transitions.
  The room timer is in the middle row, and will display the time for the previous room.
  The level timer is in the bottom row, and will display the overall time for the current level so far. It will reset when going into a new level.
  Both of these timers will reset when using one of the Stage Control features.

  In addition, in the top left is displayed a counter that represents how many total lag frames have occurred so far (capped at 99). It counts loading frames in-between rooms, as well.
  This lag counter also resets when going into a new level or using one of the Stage Control features.
- **Scroll Glitch**: Enables a tool that kills Simon whenever a Scroll Glitch is failed. Intended to be used in combination with savestates.
  If in a stage where an RTA-viable Scroll Glitch is present (that is: 05-2, 06-1, 07-1, 13-1, 14-2, 17-1), the game will start checking if the blocks that need to be manipulated have been manipped correctly, and kill Simon if they haven't.
  There are a few additional conditions to prevent early deaths, such as not killing Simon in Stage 05-2 if he's not facing left.
  For the Stage 14 Top Block and the rightmost block of Stage 17, Simon will only be killed if either of the 2 blocks that can work have not been manipped.
- **Input Display**: Shows the currently held inputs on the top right side of the screen.
- **Dracula Tool**: Print some useful information for Dracula 2-cycle practice on the top center of the screen (only if in Dracula's room):
  - **Pause Buffer frames**: After pausing and then unpausing, the amount of time the game was paused for is displayed on screen. This is intended for Fast Pattern practice, where the game needs to be paused for exactly 10 frames. If early, an "E" is displayed next to the number, if late it displays an "L", and if pausing for exactly 10 frames, it displays a heart.
  - **Jump-Whip Stagger frames**: Prints the amount of frames elapsed in-between an A press and a B press (up to 8 frames). This is intended for Ascending Crit practice.

## Repository structure
To be written! If you'd like to contribute, I am open to it, but perhaps reach out to me first so we can talk some details out (preferably on Discord at SBDWolf#3244).

## Credits
**SBDWolf**: Main author of this suite of practice tools.

**bogaa**: Author of a different Practice/Tinkering Hack for which I took and readapted a lot of code (particularly the menu system).

**trisk**: Author of a few Scroll Glitch Death tools and a Dracula Practice tools that I readapted into here.
