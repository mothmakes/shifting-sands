///Initilize the variables required for the state engine.
function state_machine_init() {
	state=noone;
	state_next=state;
	state_name="Unknown";
	state_timer=0;
	state_map=ds_map_create();
	state_stack=ds_stack_create();
	state_new=true;
	state_var[0]=0; //Useful for storing variables specific to a specific state.
	//Add any new variables you might need for your game here.
	state_can_interrupt=true;
	//Good examples might be
	//state_can_interrupt = false;
	//state_is_invincible = false;
	//state_direction = -1;
}

/// @param state
function state_init() {
	//Sets the default state for the object.  Called only in the create event.
	if(is_real(argument[0]))
	{
	    state=argument[0];
	    state_name="Unknown (Use the name to switch next time)";
	}
	else
	{
	    state=ds_map_find_value(state_map,argument[0]);
	    state_name=argument[0];
	}    
	state_next=state;
	ds_stack_push(state_stack,state);
	state_new=true;



}

function state_execute() {
	if(script_exists(state))
	  script_execute(state)
	else
	  state_switch(ds_map_find_first(state_map));
}

/// @param Name <string>
/// @param Script
function state_create() {
	ds_map_replace(state_map,argument[0],argument[1]);


}

function state_cleanup() {
	ds_map_destroy(state_map);
	ds_stack_destroy(state_stack);


}

/// @param state <script or name>
/// @param <push to stack?>
function state_switch() {
	var _push = true;
	if(argument_count>1)
	  _push=argument[1];
  
  
	if(is_real(argument[0]))
	{ //you passed a specific script, set it as our next state.
	  state_next=argument[0];
	  state_name="Unknown (Use the name to switch next time)";
	}
	else
	{   //you passed the name of a state, let's try and find it.
	  if(ds_map_exists(state_map,argument[0]))
	  {
	    state_next=ds_map_find_value(state_map,argument[0]);
	    state_name=argument[0]; 
	  }
	  else
	  {
	    show_debug_message("Tried to switch to a non-existent state.  Moving to first state.")
	    state_next=ds_map_find_first(state_map);
	    state_name="Unknown (Tried to switch to a non-existant state)";
	  }
	}
	if(_push) 
	  ds_stack_push(state_stack,state_next);
}

function state_switch_previous() {
	ds_stack_pop(state_stack);
	var _state=ds_stack_top(state_stack);
	state_switch(_state,false);
}

function state_update() {
	if(state_next != state)
	{
	  state=state_next;
	  state_timer=0;
	  state_new=true;
	}
	else
	{
	  state_timer++;
	  state_new=false;
	}
}
