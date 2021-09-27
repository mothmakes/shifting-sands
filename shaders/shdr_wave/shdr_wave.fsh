//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float texelH;
uniform float texelW;
uniform float springs[2000];
uniform float time;
uniform float springCount;


void main()
{
	vec2 p = v_vTexcoord;
	float py = 1.0 -p.y;
	float pixelsIn = (p.x / texelW);
	int chunk = int(floor(p.x * springCount));
	int nextChunk = int(min(floor(p.x * springCount)+1.0, 99.0));
	float chunkPercent = (p.x * springCount) - floor(p.x*springCount);
	p.y = p.y + ((sin((pixelsIn*0.2) + time)*(1.5*texelH)) * py);
	p.y = p.y + ((sin((pixelsIn*0.3) - time*1.2)*(1.5*texelH)) * py);
	p.y = p.y + (mix(springs[chunk] * texelH, springs[nextChunk] * texelH, chunkPercent) * py);
	p.y = max(p.y, 0.0);
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, p );
}
