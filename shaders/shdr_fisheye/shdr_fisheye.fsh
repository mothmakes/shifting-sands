//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
const float PI = 3.1415926535;

void main()
{
  float apertureHalf = 0.5 * 178.0 * (PI / 180.0);
  float maxFactor = sin(apertureHalf);
  
  vec2 uv;
  vec2 xy = 2.0 * v_vTexcoord.xy - 1.0;
  float d = length(xy);
  if (d < (2.0-maxFactor))
  {
    d = length(xy * maxFactor);
    float z = sqrt(1.0 - d * d);
    float r = atan(d, z) / PI;
    float phi = atan(xy.y, xy.x);
    
    uv.x = r * cos(phi) + 0.5;
    uv.y = r * sin(phi) + 0.5;
  }
  else
  {
    uv = v_vTexcoord.xy;
  }
  vec4 c = texture2D(gm_BaseTexture, uv);
  gl_FragColor = c;
}