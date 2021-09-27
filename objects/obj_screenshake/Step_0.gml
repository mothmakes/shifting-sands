if (shake) 
{ 
   shake_time -= 1; 
   xval = choose(-shake_magnitude, shake_magnitude); 
   yval = choose(-shake_magnitude, shake_magnitude);  

   if (shake_time <= 0) 
   { 
      shake_magnitude -= shake_fade; 

      if (shake_magnitude <= 0) 
      { 
         xval = 0;
		 yval = 0;
         shake = false; 
      } 
   } 
}