// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_effects(){

}

/// @function                   screenshake(_time, _magnitude, _fade);
/// @param  {real}  _time       The length of time - in steps - to shake the screen
/// @param  {real}  _magnitude  The amount of screenshake to apply
/// @param  {real}  _fade       How quickly the screenshake effect will fade out
/// @description    Set the screenshake object variables.

function screenshake(_time, _magnitude, _fade)
{
   with (obj_screenshake)
   {
      shake = true;
      shake_time = _time;
      shake_magnitude = _magnitude;
      shake_fade = _fade;
   }
}

/// @function                   screenflash(_time, _alpha, _fade);
/// @param  {real}  _time       The length of time - in steps - to flash the screen
/// @param  {real}  _alpha		The amount of screenflash to apply
/// @param  {real}  _fade       How quickly the screenflash effect will fade out
/// @description    Set the screenshake object variables.

function screenflash(_time, _alpha, _fade)
{
   with (obj_screenflash)
   {
      flash = true;
      flash_time = _time;
      flash_alpha = _alpha;
      flash_fade = _fade;
   }
}

/// @function                   screenfade(_time, _fade_in, _alpha, _speed);
/// @param  {real}  _time       The length of time - in steps - to keep the screen at the alpha value
/// @param  {bool}  _fade_in	Whether the fade should be a fade in or fade out
/// @param  {real}  _alpha		The starting fade alpha
/// @param  {real}  _speed      How quickly the screenfade effect will fade out
/// @description    Set the screenshake object variables.

function screenfade(_time, _fade_in, _alpha, _speed)
{
   with (obj_screenfade)
   {
      fade = true;
	  fade_in = _fade_in;
      fade_time = _time;
      fade_alpha = _alpha;
      fade_speed = _speed;
   }
}