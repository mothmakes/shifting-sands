//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float blur_steps;
uniform vec2 texel_size;
uniform float sigma;
uniform vec2 blur_vector;

float weight(float pos) { //Gauss 2D
	return exp(-(pos*pos)/ (2.0 * sigma * sigma));
}

void main()
{
	highp vec4 blurred_col = texture2D(gm_BaseTexture, v_vTexcoord);
	
	vec2 sample;
	float offset_D1, offset_L, sample_weight_D1, sample_weight_D2, sample_weight_L;
	float total_weight = 1.0;
	float kernel = 2.0 * blur_steps + 1.0;
	for(offset_D1 = 1.0; offset_D1 <= (2.0 * blur_steps); offset_D1+= 2.0) {
		sample_weight_D1 = weight(offset_D1/kernel);
		sample_weight_D2 = weight((offset_D1+1.0)/kernel);
		sample_weight_L = sample_weight_D1 + sample_weight_D2;
		total_weight += 2.0 * sample_weight_L;
		
		offset_L = (offset_D1 * sample_weight_D1 + (offset_D1+1.0) * sample_weight_D2) / sample_weight_L;
		
		sample = v_vTexcoord - offset_L * texel_size * blur_vector;
		blurred_col += texture2D(gm_BaseTexture, sample) * sample_weight_L;
		
		sample = v_vTexcoord + offset_L * texel_size * blur_vector;
		blurred_col += texture2D(gm_BaseTexture, sample) * sample_weight_L;
	}
    gl_FragColor = v_vColour * blurred_col / total_weight;
	
}
