// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_constants(){
	#macro ALIGN_CENTRE 1
	#macro ALIGN_JUSTIFY -1
	#macro TILE_SIZE 16
	#macro CENTRE_TILE (TILE_SIZE / 2)
	#macro WATER_DIVISION 2
	#macro STEP_DISTANCE 3
	#macro SURF_SCALE 0.5
	
	// Player Animations
	#macro IDLE_START 0
	#macro IDLE_END 4
	#macro RUN_START 5
	#macro RUN_END 13
	#macro JUMP_START 14
	#macro JUMP_END 23
	#macro STAGGER_START 24
	#macro STAGGER_END 26
	#macro STAND_START 27
	#macro STAND_END 28
	#macro WALLSLIDE_START 29
	#macro WALLSLIDE_END 29
	
	enum gateTypes {
		UNDEFINED,
		IN,
		OUT,
		OR,
		AND,
		NOT
	}
	
	enum edgeDirs {
		UP,
		FUP,
		RIGHT,
		FRIGHT,
		DOWN,
		FDOWN,
		LEFT,
		FLEFT
	}
}